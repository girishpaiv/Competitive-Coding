// 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13. What is the 10001st prime number?
#include <iostream>
#include <bitset>

using namespace std;

int N = 10001;
const int S = 500001;

int main()
{
    // Construct prime number list till N-1 using Sieve of Eratosthenes
    bitset<S> PRIMES; // All prime number indices will have value 0
    for (long int i = 2; i < S-1 ; i++) {
        for (long int j = i; i*j < S; j++) {
            PRIMES[i*j] = 1;
        }
    }
    
    int i = 2;
    for (int index = 0; index < N && i < S; i++) {
        if (PRIMES[i] == 0) {
            index++;
        }
    }
    cout<<i-1;
}
