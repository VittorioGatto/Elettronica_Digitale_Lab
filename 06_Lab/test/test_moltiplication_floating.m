clear all
clc

A = zeros(256,11);

for  decimal =    -128:1:127
    bit = logical(bitget(decimal,8:-1:1,'int8'));
    
    A(decimal+129,1) = decimal;         %Prima numero rappresentato
    A(decimal+129,2) = decimal*3.75;    %Seconda colonna numero moltiplicazione esatto
    
    left_shift = false(1,8);
    right_shift = false(1,8);
    
    %moltiplicazione per 3.75
    left_shift(1,1:6) = bit(1,3:8);     %moltiplicazione binaria per 2^2
    if(bit(1) == 0)
        right_shift(1,3:8) = bit(1,1:6);    %moltiplicazione binaria per 2^-2
        right_shift = not(right_shift);     %complemento a 1
        
        %se il bit7 e il bit8 sono contemporaneamente a 1 allora non fare
        %il complemento a 2 ma lascia il complemento a 1
        if(not(bit(8)  && bit(7)))
            right_shift = binarySum(right_shift,logical([0, 0, 0, 0, 0, 0, 0, 1])); %complemento a 2
        end
    else
        right_shift = not(bit) ;                     %complemento a 1
        right_shift = binarySum(right_shift,logical([0, 0, 0, 0, 0, 0, 0, 1])); %complemento a 2
        right_shift(1,3:8) = right_shift(1,1:6);    %moltiplicazione binaria per 2^-2
        
        %se il bit7 è a 0 e il bit8 è a 1 somma uno
         if(bit(8) && not(bit(7)))
             right_shift = binarySum(right_shift,logical([0, 0, 0, 0, 0, 0, 0, 1]));
         end
    end
    
    result_bin = binarySum(left_shift,right_shift);
    
    
    A(decimal+129, 4:11) = result_bin;  %rappresentazione binaria della somma left_shift + right_shift
    %conversione da complemento a 2 a decimale
    result_dec = bi2de(result_bin,'left-msb');
     if(decimal < 0)
         result_dec = result_dec - 256;
     end
    A(decimal+129, 3) = result_dec;
    
end


function [c] = binarySum(a, b)
    
    c = false(1,8);
    carry = false;
    
    for i = size(a,2):-1:1
        if(a(1,i) == 0 && b(1,i) == 0 && carry == 0)
            carry = 0;
            c(1,i) = 0;
        elseif(a(1,i) == 1 && b(1,i) == 0 && carry == 0)
            carry = 0;
            c(1,i) = 1;
        elseif(a(1,i) == 0 && b(1,i) == 1 && carry == 0)
            carry = 0;
            c(1,i) = 1;
        elseif(a(1,i) == 1 && b(1,i) == 1 && carry == 0)
            carry = 1;
            c(1,i) = 0;
        elseif(a(1,i) == 0 && b(1,i) == 1 && carry == 1)
            carry = 1;
            c(1,i) = 0;
        elseif(a(1,i) == 1 && b(1,i) == 0 && carry == 1)
            carry = 1;
            c(1,i) = 0;
        elseif(a(1,i) == 1 && b(1,i) == 1 && carry == 1)
            carry = 1;
            c(1,i) = 1;
        elseif(a(1,i) == 0 && b(1,i) == 0 && carry == 1)
            carry = 0;
            c(1,i) = 1;
        end
    end
   
end