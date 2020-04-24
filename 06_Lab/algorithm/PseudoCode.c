//
//  PseudoCode.c

#include <stdio.h>

int MEM_A[1024] = { 0 };
int MEM_B[1024]  = { 0 };
int current_address = 0; //current address reading/writing
bool cs = false; //chip select 0 MEM_B 1 MEM_A
bool wr = false; //register write
bool rd = false; //register read
bool done = false; //signal done

int previousX = 0; //previous input x (datapath) examined
int previousXsum = 0; //previous sum of x's(sommatoria Ki)

void writeMEM_A(int data_in[]);
int processX(int x); //process datapath, returns y (see scheme)
void writeMEM_B(int y);

void main(){
    int y;
    
    writeMEM_A(addresses);
    
    for(int i = 0; i <= 1023; i++){
        current_address = i;
        
        y = processX(MEM_A[i]);
        writeMEM_B(y);
        
        previousXsum = MEM_A[i] + previousX;
        previousX = MEM_A[i];
    }
    
    done = true;
}

void writeMEM_A(int data_in[]){
    cs = true; //selected MEM_A
    wr = true;
    rd = false;
    
    for(int i = 0; i <= 1023; i++){
        MEM_A[i] = data_in[i];
    }
}

//Datapath
int processX(int x){
    cs = true; //selected MEM_A
    wr = false;
    rd = true; // reading MEM_A
    
    int y = 3.75*x + 2*(x + previousXsum) + 0.5*(x - previousX);
    
    return y;
}

void writeMEM_B(int y){
    cs = false; //selected MEM_B
    wr = true; //writing MEM_B
    read = false;
    
    MEM_B[current_address] = y;
}
