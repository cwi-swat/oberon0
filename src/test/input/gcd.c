

int x;
int y;

int main(int argc, char **argv) {
    Read(&(x));
    Read(&(y));
    while ((x != y)) {
        if ((x > y)) {
            x = (x - y);
        }
        else {
            y = (y - x);
        }
        
    }
    WriteLn(x);
}