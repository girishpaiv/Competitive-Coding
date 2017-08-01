// largest prime factor of the number 600851475143

#include <iostream>

using namespace std;

long long int N = 600851475143;

int main()
{
    int res = -1;
    for ( int i = 2; i <= N; i++) {
        if (N % i == 0) {
            if (i > res) {
                res = i;
                N /= res;
            }
        }
    }

    cout<<res;
}
