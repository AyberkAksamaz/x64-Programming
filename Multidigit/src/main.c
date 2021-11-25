#include<stdio.h>
#include<stdlib.h>

void mymul(
		unsigned long *c,
		unsigned long *a, unsigned long alen,
		unsigned long *b, unsigned long blen
);


void myrand(unsigned long *a, int len){
	int i;
	for (i = 0; i < len; i++) {
		a[i] = random()*random();
	}
}

void myprint(char *str, unsigned long *a, int len){
	int i;
	printf("%s := %lu", str, a[0]);
	for (i = 1; i < len; i++) {
		printf(" + %lu*(2^64)^%d", a[i], i);
	}
	printf(";\n\n");
}


int main(){
	unsigned long a[9], b[12], c[21];

	myrand(a, 9);
	myrand(b, 12);


	int s = sizeof(a[0]);
	printf("kjhgkjh %d\n", s);

   mymul(c, a, 9, b, 12);

	myprint("a", a, 9);
	myprint("b", b, 12);
	myprint("c", c, 21);

	printf("a*b eq c;\n\n");



	return 1;
}
