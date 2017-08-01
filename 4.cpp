// Find the largest palindrome made from the product of two 3-digit numbers. Eg for 2-digit numbers 9009 = 91 x 99.

#include <iostream>
#include <math.h>

using namespace std;

int N = 999;

bool isPalindrome (int num) {
    int num_reverse = 0;
    int num_orig = num;
    for ( int i = 1; num > 0; i++) {
        num_reverse = num_reverse * 10 + num % 10;
        num /= 10;
    }
    return (num_orig == num_reverse);
}

int main()
{
    int res = -1;
    for (int i = N; i > (N+1)/2; i--) {
        for (int j = i; j > 0; j--) {
            if (isPalindrome(i*j) & i*j > res) {
                res = i * j;
            }
        }
    }
    cout<<res;
}
