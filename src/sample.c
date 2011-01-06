
#include <builtins.h>
















static void     h_g_f_Nesting(int (*abc), int (*z), int (*x), 
			      int (*y))
{

	Write((*x));
	Write((*z));
	(*abc) = (((*x) + (*z)) + (*y));

}

static void     g_f_Nesting(int abc, int (*x), 
			    int (*y))
{

	(*y) = 12;
	(*x) = 42;

}

static void     f_Nesting(int x, int (*z), 
			  int (*y))
{

	(*y) = 3;
	Write(x);
	(*z) = ((*z) + 1);

}

static void 
Nesting()
{
	int             x;
	int             y;

	y = 1;
	x = 3;
	f_Nesting(x, &(y), &y);

}




static void 
Multiply()
{
	int             x;
	int             y;
	int             z;

	Read(&(x));
	Read(&(y));
	z = 0;

	while ((x > 0)) {

		if (((x % 2) == 1)) {
			z = (z + y);

		}
		y = (2 * y);
		x = (x / 2);

	}

	Write(x);
	Write(y);
	Write(z);
	WriteLn();

}




static void 
Divide()
{
	int             x;
	int             y;
	int             r;
	int             q;
	int             w;

	Read(&(x));
	Read(&(y));
	r = x;
	q = 0;
	w = y;

	while ((w <= r)) {
		w = (2 * w);

	}


	while ((w > y)) {
		q = (2 * q);
		w = (w / 2);

		if ((w <= r)) {
			r = (r - w);
			q = (q + 1);

		}
	}

	Write(x);
	Write(y);
	Write(q);
	Write(r);
	WriteLn();

}




static void 
BinSearch()
{
	int             i;
	int             j;
	int             k;
	int             n;
	int             x;
	int             a[32];

	Read(&(n));
	k = 0;

	while ((k < n)) {
		Read(&(a[k]));
		k = (k + 1);

	}

	Read(&(x));
	i = 0;
	j = n;

	while ((i < j)) {
		k = ((i + j) / 2);

		if ((x < a[k])) {
			j = k;

		} else {
			i = (k + 1);

		}



	}

	Write(i);
	Write(j);
	Write(a[j]);
	WriteLn();

}

int 
main(int argc, char **argv)
{

}
