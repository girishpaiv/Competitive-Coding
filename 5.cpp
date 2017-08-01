// smallest positive number that is evenly divisible by all of the numbers from 1 to 20

#include <iostream>
#include <math.h>

using namespace std;

int N = 20;

int main()
{
    long long int res = N;
    for (int i = N-1; i > 0; i--) {
        cout<<res<<" ";
        int num = i;
        int res_tmp = res;
        for (int j = i; j > 1 ; j--) {
            if (num % j == 0 && res_tmp % j == 0) {
                num /= j;
                res_tmp /= j;
            }
        }
        cout<<num<<endl;
        //if (res % num != 0) {
            res *= num;
        //}
    }
    cout<<res;
}
