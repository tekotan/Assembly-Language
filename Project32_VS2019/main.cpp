#include <iostream>
#include <time.h>
#include "multiarray.h"
using namespace std;

int main()
{
	// Fill an array with pseudorandom integers.
	const unsigned ARRAY_SIZE = 10;
	const unsigned LOOP_SIZE = 700000;

	long array[ARRAY_SIZE];
	for (unsigned i = 0; i < ARRAY_SIZE; i++)
		array[i] = rand();

	long mval = 55;		// multiplier
	time_t startTime;
	time_t endTime;
	int n;

	// Test the Assembly language version:

	time(&startTime);

	for (n = 0; n < LOOP_SIZE; n++)
		AsmMultArray(mval, array, ARRAY_SIZE);

	time(&endTime);
	cout << "Elapsed ASM time: " << long(endTime - startTime)
		<< " seconds" << endl;

	long array4[] = { -5, 10, 20, 14, 17, 26, 42, 22, 19, -5 };
	AsmMultArray(mval, array4, ARRAY_SIZE);
	for (unsigned i = 0; i < ARRAY_SIZE; i++)
		cout << array4[i]*mval << ", ";
	cout << "\n";
	// tt

	const unsigned ARRAYSIZE = 10;
	long array1[] = { -5, 10, 20, 14, 17, 26, 42, 22, 19, -5 };
	long array2[] = { 2, 5, 2, 4, 7, 6, 4, 12, 9, -5 };
	long array3[] = { 3, 4, 5, 6, 7, 8, 10, 20, 3, 4 };

	// Test the Assembly language subroutine

	SumThreeArrays(array1, array2, array3, ARRAYSIZE);

	for (unsigned i = 0; i < ARRAY_SIZE; i++)
		cout << array1[i] << ", ";

	cout << endl;

	return 0;
}
