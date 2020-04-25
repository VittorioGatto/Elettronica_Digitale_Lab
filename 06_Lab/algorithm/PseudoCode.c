//
//  PseudoCode
//
//

#include <stdio.h>
#include <stdlib.h> //remove before pasting

int data_in[1024] = { 0 };
int MEM_A[1024] = { 0 };
int MEM_B[1024]  = { 0 };

int current_address = 0; //current address reading/writing
int cs = 0; //chip select 0 MEM_B 1 MEM_A
int wr = 0; //register write
int rd = 0; //register read
int done = 0; //signal done

int previousX = 0; //previous input x (datapath) examined
int previousXsum = 0; //previous sum of x's(sommatoria Ki)

void writeMEM_A(int data_in[]);
int processX(int x); //process datapath, returns y (see scheme)
void writeMEM_B(int y);
void generateRandoms(int lower, int upper);

int main(){
    int y;
    
    generateRandoms(-128, 127); //remove befor pasting
    writeMEM_A(data_in);
    
    for(int i = 0; i < 1024; i++){
        current_address = i;
        
        y = processX(MEM_A[i]);
        writeMEM_B(y);
        
        previousXsum = MEM_A[i] + previousX;
        previousX = MEM_A[i];
    }
    
    done = 1;
    
    printf("-------OUTPUT DATA---------\n");
    for(int i = 0; i < 1024; i++)
        printf("%d \n", MEM_B[i]);
    
    return 1;
}

void writeMEM_A(int data_in[]){
    cs = 1; //selected MEM_A
    wr = 1;
    rd = 0;
    
    for(int i = 0; i < 1024; i++){
        MEM_A[i] = data_in[i];
    }
}

//Datapath
int processX(int x){
    cs = 1; //selected MEM_A
    wr = 0;
    rd = 1; // reading MEM_A
    
    int y = 3.75*x + 2*(x + previousXsum) + 0.5*(x - previousX);
    
    return y;
}

void writeMEM_B(int y){
    cs = 0; //selected MEM_B
    wr = 1; //writing MEM_B
    rd = 0;
    
    MEM_B[current_address] = y;
}

//remove before pasting
void generateRandoms(int lower, int upper){
    for (int i = 0; i < 1024; i++) {
        data_in[i] = (rand() %
           (upper - lower + 1)) + lower;
        printf("%d \n", data_in[i]);
    }
}


