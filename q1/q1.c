#include <stdio.h>
extern void Next_Largest_Element(long long int n,long long int A[],long long int B[]);

int main()
{
    long long int n;
    scanf("%lld", &n);
    long long int A[n], B[n];
    for(long long int i = 0; i < n; i++)
    {
        scanf("%lld", &A[i]);
    }
    Next_Largest_Element(n,A,B);
    for(long long int i = 0; i < n; i++)
    {
        if(B[i] == -1)
        {
            printf("-1 ");
        }
        else
        {
            printf("%lld ", A[B[i]]);
        }
    }
    printf("\n");
    return 0;
}