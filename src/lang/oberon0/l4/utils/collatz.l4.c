
#include <builtins.h>


int even;
int odd;

static void doCollatz_computeEven(int (*current), int (*currentEven));
static void doCollatz_printSequence(int (*current), int (*currentEven));
static void doCollatz();


static void doCollatz_computeEven(int (*current), int (*currentEven)) {
  
  
if ((((*current)%2) == 0)) {
  (*currentEven) = even;

}


else {
  (*currentEven) = odd;

}


}

static void doCollatz_printSequence(int (*current), int (*currentEven)) {
  
  
while (((*current) != 1)) {
   doCollatz_computeEven(&((*current)), &((*currentEven)))
Write((*current))

if (((*currentEven) == even)) {
  (*current) = ((*current)/2);

}


else {
  (*current) = (((*current)*3)+1);

}


}
WriteLn()

}

static void doCollatz() {
  int current;
int currentEven;

  Read(&(current))
doCollatz_printSequence(&(current), &(currentEven))

}


int main(int argc, char **argv) {
  even = 1;
odd = 0;
doCollatz()

}
