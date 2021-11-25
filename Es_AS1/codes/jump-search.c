#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int jump_Search(int a[], int size, int item) {
	int i = 0;
	int m = sqrt(size); //initializing block size (use integer sqrt algorithm here!!)
	int t = m;
	while(a[m] <= item && m < size) { // the control will continue to jump the blocks
		i = m;  // shift the block
		m += t;
		if(i > size - 1) // check if index exceeds the array size
			return -1;
	}
	for(int x = i; x < m; x++) { //linear search in current block
		if(a[x] == item)
			return x; //position of element being searched
	}
	return -1;
}
int main() {
	int size = 10, item = 55; // array size, item wanted
	int arr[] = {5, 10, 20, 40, 45, 55, 70, 75, 90, 95};
	int loc = jump_Search(arr, size, item);
	
	if(loc >= 0) {
		printf("Item found at location: %d\n", loc);
	}else{
		printf("Item is not found in the list.");
	}
}
