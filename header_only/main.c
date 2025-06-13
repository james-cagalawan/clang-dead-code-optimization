#include <stdio.h>
#include "lib.h"

int main(int argc, char** argv) {
    int a, b;
    printf("Enter two integers: ");
    scanf("%d %d", &a, &b);
    printf("%d\n", add(a, b));
    return 0;
}