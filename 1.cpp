// Find the sum of all the multiples of 3 or 5 below 1000.

#include <iostream>

using namespace std;

int N = 1000;

int main()
{
    int sum = 0;
    for (int i = 3; i < N; i+=3) {
            sum += i;
    }
    for (int i = 5; i < N; i+=5) {
        if (i % 3 != 0) {
            sum += i;
        }
    }
    cout<<sum;

}
