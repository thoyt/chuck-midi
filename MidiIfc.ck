public class MidiIfc {
    
    MidiOut mout;
    MidiMsg on_msg[16];
    MidiMsg off_msg[16];
    MidiMsg aftertouch_msg[16];
    MidiMsg pitchbend_msg[16];
    
    int i;
    mout.open(0) => int o;
    if (!o) { me.exit(); }
    
    for (0 => i; i < 16; i++){
        128 + i => off_msg[i].data1;
    }
    for (0 => i; i < 16; i++){
        144 + i => on_msg[i].data1;
    }
    for (0 => int i; i < 16; i++){
        208 + i => aftertouch_msg[i].data1;
    }
    for (0 => int i; i < 16; i++){
        224 + i => pitchbend_msg[i].data1;
    }
    
    fun void noteOn(int channel, int note, float vel){
        on_msg[channel - 1] @=> MidiMsg msg;
        note => msg.data2;
        Std.ftoi(vel * 127) => msg.data3;
        mout.send(msg) => int o;
    }
    
    fun void noteOff(int channel, int note, float vel){
        off_msg[channel - 1] @=> MidiMsg msg;
        note => msg.data2;
        Std.ftoi(vel * 127) => msg.data3;
        mout.send(msg) => int o;
    }
    
    fun void allOff(int channel){
        MidiMsg msg;
        176 + channel => msg.data1;
        123 => msg.data2;
        0 => msg.data3;
        mout.send(msg) => int o;
    }
    
    fun void afterTouch(int channel, int note, float vel){
        aftertouch_msg[channel - 1] @=> MidiMsg msg;
        Std.ftoi(vel * 127) => msg.data3 => msg.data2;
        mout.send(msg) => int o;
    }
    
    fun void playCycle(int channel, int cycle[], dur dNote, dur dTotal, int octave, float onRatio){
        cycle.cap() => int N;
        int note;
        float vel;
        0.2 => float vel_min;
        0.9 => float vel_max;
        now + dTotal => time later;
        while (now < later){
            for (0 => int i; i < N; i++){
                cycle[i] + 12 * octave => note;
                vel_min + (vel_max - vel_min) * ((i + 1) / (N * 1.0)) => vel;
                //Math.random2f(vel_min, vel_max) => vel;
                if (now < later){
                    noteOn(channel, note, vel);
                    dNote * onRatio => now;
                    noteOff(channel, note, vel);
                    dNote * (1.0 - onRatio) => now;
                }
            }
        }   
    }
    fun void playCycle(int channel, int cycle[], dur dNote[], dur dTotal, int octave, float onRatio){
        cycle.cap() => int N;
        int note;
        float vel;
        0.2 => float vel_min;
        0.9 => float vel_max;
        now + dTotal => time later;
        while (now < later){
            for (0 => int i; i < N; i++){
                cycle[i] + 12 * octave => note;
                vel_min + (vel_max - vel_min) * ((i + 1) / (N * 1.0)) => vel;
                //Math.random2f(vel_min, vel_max) => vel;
                if (now < later){
                    noteOn(channel, note, vel);
                    dNote[i] * onRatio => now;
                    noteOff(channel, note, vel);
                    dNote[i] * (1.0 - onRatio) => now;
                }
            }
        }   
    }
    
    fun void pitchBend(int channel, float amt){
        Std.ftoi((amt + 1.0) * 0.5 * 127) => int iamt;
        pitchbend_msg[channel - 1] @=> MidiMsg msg;
        1 => msg.data2;
        iamt => msg.data3;
        mout.send(msg) => int o;
    }
    /*
    fun void pitchBend(int channel, float amt){
        // amount should be between -1 and 1, 0 is no pitchbend
        // 8192 is no pitchbend
        // which is 64 => msg.data2, 0 => msg.data3;
        Std.ftoi((amt + 1.0) * 8192) => int iamt;
        if(iamt == 16384){
            16383 => iamt;
        }
        iamt / 128 => int d2;
        iamt - (d2 * 128) => int d3;
        <<< amt, iamt, d2, d3 >>>;
        pitchbend_msg[channel - 1] @=> MidiMsg msg;
        d2 => msg.data2;
        d3 => msg.data3;
        mout.send(msg) => int o;
    }
    */
    
}
