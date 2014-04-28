public class ArrayUtil {
    // octaveShift (int notes[], int octaves)
    // choose (int n, int octaves)
    // sum (int list[])
    // range (int a, int b)
    // sort (int list[])
    // max (int list[])
    
    fun int[] octaveShift(int notes[], int oct){
        notes.cap() => int N;
        int r[N];
        for (0 => int i; i < N; i++){
            notes[i] + (12 * oct) => r[i];
        }
        return r;
    }
    
    fun int max(int a[]){
        a[0] => int rv;
        int tmp;
        for (1 => int i; i < a.cap(); i++){
            if (a[i] > tmp){
                a[i] => tmp;
            }
        }
        return rv;
    }
    
    // choose n elements randomly from a list
    fun int[] choose(int scale[], int n, int oct){
        int r[n];
        int choice;
        int octave;
        for (0 => int i; i < n; i++){
            Math.random2(0, scale.cap() - 1) => choice;
            if (oct > 0){
                Math.random2(0, oct) => octave;    
            }
            scale[choice] + 12*octave => r[i];
        }
        return r;
    }
    
    fun int sum(int array[]){
        0 => int acc;
        for (0 => int i; i < array.cap(); i++){
            array[i] +=> acc;
        }
        return acc;
    }
    
    // generate a range from a to b (inc, exc)
    fun int[] range(int a, int b){
        b - a => int M;
        int r[M];
        for (0 => int i; i < M; i++){
            a + i => r[i];
        }
        r;
    }
    
    fun int[] sort(int l[]){
        l.cap() => int N;
        int r[N];
        -1 => int smallest;
        int temp;
        int k;
        int found_ind;
        for (0 => int i; i < N; i++){
            l[i] => temp;
            i => found_ind;
            for (i => int j; j < N; j++){
                l[j] => k;
                if ((k >= smallest) && (k <= temp)){
                    k => temp;
                    j => found_ind;
                }
            }
            // swap out the smallest
            l[found_ind] => smallest;
            l[i] => l[found_ind];
            smallest => l[i];            
        }
        return l;
    }
    
    fun int[] morph(int a[], int step_choices[], int max){
        step_choices.cap() => int Nsc;
        a.cap() => int Ni;
        int rv[Ni];
        int choice;
        for (0 => int i; i < Ni; i++){
            a[i] + step_choices[Math.random2(0, Nsc-1)] => choice;
            if (choice > max){
                Math.random2(0, max) => rv[i];
            } else if (choice < 0) {
                Math.random2(0, max) => rv[i];
            } else {
                choice => rv[i];
            }
        }
        return rv;
    }
    
}