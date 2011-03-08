
#include <builtins.h>


int even;
int odd;

static void doCollatz_computeEven();
static void doCollatz_printSequence();
static void doCollatz();


static void doCollatz_computeEven() {
  
  
if (((current%2) == 0)) {
  currentEven = even;

}


else {
  currentEven = odd;

}


}

static void doCollatz_printSequence() {
  
  
while ((current != 1)) {
   doCollatz_computeEven()
Write(current)

if ((currentEven == even)) {
  current = (current/2);

}


else {
  current = ((current*3)+1);

}


}

}

static void doCollatz() {
  int current;
int currentEven;

  Read(&(current))
doCollatz_printSequence()

}


int main(int argc, char **argv) {
  even = 1;
odd = 0;
doCollatz()

}
