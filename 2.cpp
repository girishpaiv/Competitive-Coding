// Find sum of the even-valued terms in Fibonacci sequence whose values do not exceed four million

#include <iostream>

using namespace std;

int N = 4000000;

int main()
{
    int sum = 0;
    int n1 = 1, n2 = 1;
    for ( int i = 0; n2 < N; i++) {
        n2 = n1 + n2;
        n1 = n2 - n1;
        if (n2 % 2 == 0) {
            sum += n2;
        }
    }

    cout<<sum;
}
