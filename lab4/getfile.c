#include <stdio.h>
extern int sum(int *array, int count); // establish function in addlist.s
int main() {
    int count; 
    int s;

    FILE *file;
    file = fopen("data.txt", "r"); // open data.txt in read mode
    fscanf(file, "%d", &count); // gets 1st value and puts it in count
    int array[count]; // make array to store variable

    for (int i = 0; i < count; i++) {fscanf(file, "%d", &array[i]);} // fills array with variables
    fclose (file); // close file now that we no longer need it

    s = sum(array, count); // runs assembly program
    printf("%d\n", s); // print output
    printf("\n");
    return 0;
}