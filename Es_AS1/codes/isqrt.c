#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(void) {

	int num = 125;
	int x0 = num / 2; // Initial estimate

	int x1 = ( x0 + num / x0 ) / 2; // Update
	while ( x1 < x0 ) { // This also checks for cycle
		x0 = x1;
		x1 = ( x0 + num / x0 ) / 2;
	}
	printf("Integer square root of '%d' is '%d'", num, x0);
}
