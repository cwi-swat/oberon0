#include <builtins.h>
#define INPUTLENGTH 5


int             input[INPUTLENGTH];
int             i;


static void     QuickSort_Swap(int (*x), 
			       int (*y))
{
	int             temp;

	temp = (*x);
	(*x) = (*y);
	(*y) = temp;

}

static void 
QuickSort(int (*array)[INPUTLENGTH], int left, int right)
{
	int             pivot;
	int             leftIdx;
	int             rightIdx;

	leftIdx = left;
	rightIdx = right;

	if (((right - left) > 0)) {
		pivot = ((left + right) / 2);

		while (((leftIdx <= pivot) && (rightIdx >= pivot))) {

			while ((((*array)[leftIdx] < (*array)[pivot]) && (leftIdx <= pivot))) {
				leftIdx = (leftIdx + 1);

			}

			while ((((*array)[rightIdx] > (*array)[pivot]) && (rightIdx >= pivot))) {
				rightIdx = (rightIdx - 1);

			}
			QuickSort_Swap(&((*array)[leftIdx]), &((*array)[rightIdx]));
			leftIdx = (leftIdx + 1);
			rightIdx = (rightIdx - 1);

			if (((leftIdx - 1) == pivot)) {
				rightIdx = (rightIdx + 1);
				pivot = rightIdx;

			} else if (((rightIdx + 1) == pivot)) {
				leftIdx = (leftIdx - 1);
				pivot = leftIdx;

			}
		}
		QuickSort(&((*array)), left, (pivot - 1));
		QuickSort(&((*array)), (pivot + 1), right);

	}
}

int 
main(int argc, char **argv)
{
	i = 0;

	while ((i < INPUTLENGTH)) {
		Read(&(input[i]));
		i = (i + 1);

	}
	QuickSort(&(input), 0, (INPUTLENGTH - 1));
	i = 0;

	while ((i < INPUTLENGTH)) {
		Write(input[i]);
		WriteLn();
		i = (i + 1);

	}

}
