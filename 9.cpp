// Pythagorean triplet for which a + b + c = 1000, find product abc. Where a, b, c are non-zero.
#include <iostream>
#include <math.h>

using namespace std;

int N = 1000;

int main()
{

    for (int a = 1; a < N ; a++) {
        bool brk = false;
        for (int b = 1; b < N; b++) {
            double c = sqrt(a*a + b*b);
            if ((double)(a+b) + c == 1000.0) {
                cout<<(long int)(a*b*c);
                brk = true;
                break;
            }
        }
        if (brk == true) {
            break;
        }
    }
}
