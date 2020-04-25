//
//  main.c
//  PseudoCode
//
//  Created by Lorenzo Riggi on 25/04/2020.
//  Copyright © 2020 Lorenzo Riggi. All rights reserved.
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
int checkErrorInteger(int x, int y); //returns correction
int checkSaturation(int data); //returns data
void writeMEM_B(int y);

void generateRandoms(int lower, int upper); //remove before pasting

int main(){
    int y;
    int yProcessedSaturation;
    
    /*
    int test [1024] = { 0 };
    test[0] = 18;
    test[1] = 2;
    test[2] = 5;
    test[3] = 17;
     writeMEM_A(test);
     */
    
    generateRandoms(-128, 127); //remove befor pasting
    writeMEM_A(data_in);
    
    for(int i = 0; i < 1024; i++){
        current_address = i;
        
        y = processX(MEM_A[i]);
        yProcessedSaturation = checkSaturation(y);
        writeMEM_B(yProcessedSaturation);
        
        previousXsum = MEM_A[i] + previousX;
        previousX = MEM_A[i];
    }
    
    done = 1;
    
    printf("\n\n=========  OUTPUT DATA  =========\n\n");
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
    
    int Kp = (x * 4) - (x/4);
    int Kd = 0.5*(x - previousX);
    //int correction = checkErrorInteger(Kd, Kp);
    
    int y = Kp + 2*(x + previousXsum) + Kd;
    //int y = Kp + 2*(x + previousXsum) + Kd + correction;
    
    return y;
}

int checkErrorInteger(int x, int y) {
    if((x ^ y) >= 0 ) { //check if same sign (XOR)
        if((y % 3) == 0 && y > 0) { //Multiple of 3 and positive
            return 1;
        } else if((y % 3) == 0 && y < 0) { //negative
            return -1;
        } else if((x % 2) != 0) { //Odd number
            if((y % 4) != 0) { //Not multiple of 4
                if(y > 0)
                    return 1;
                else
                    return -1;
            }
        }
    } else { //different signs
        //x even and y multiple of 3
        if(((x % 2) == 0) && ((y % 3) == 0)) {
            if(x < 0 && y > 0) { //positive negative
                return 1;
            } else { //negative positive
                return -1;
            }
        }
    }
    
    return 0;
}
int checkSaturation(int data) {
    if (data > 127){
        printf("hey %d is saturated +, setting 999\n", data);
        return 999; //let's assume this is the saturated value...
    } else if (data < -128) {
        printf("hey %d is saturated -, setting -999\n", data);
        return -999;
    }
    
    return data;
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

