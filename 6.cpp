// difference between the sum of the squares of the first one hundred natural numbers and the square of the sum
#include <iostream>
#include <math.h>

using namespace std;

int N = 100;

// 2(1*2+1*3+1*4+....2*3+2*4+2*5+....3*4+3*5+3*6+....99*100)
int main()
{
    int sum = 0;
    for (int i = 1; i < N; i++) {
        for (int j = i+1; j <= N; j++) {
            sum += i*j;
        }
    }
    cout<<2*sum;
}
