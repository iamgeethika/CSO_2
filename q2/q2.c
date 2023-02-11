#include <stdio.h>
#include <stdlib.h>

extern int CountBinarySequence(int n, int difference);

int main()
{
    int n;
    scanf("%d",&n);
    printf("Number of Binary Sequences is %d\n", CountBinarySequence(n, 0));
    return 0;
}
