clear all
clc

sum = 0;
for i  = 1:1:1024
    dig_in(i) = randi(256) - 129;
    
    sum = sum + dig_in(i);
    if(i == 1)
        dig_out(i) = round(3.75*dig_in(i) + 2*sum + 0.5 * dig_in(i));
    else
    	dig_out(i) = round(3.75*dig_in(i) + 2*sum + 0.5 * (dig_in(i)-dig_in(i-1)));
    end
    
    bit(i,:) = bitget(dig_in(i),8:-1:1, 'int8');
end

fileID1 = fopen('test_data_in','w');
fileID2 = fopen('test_data_out','w');
fileID3 = fopen('test_data_in_bit','w');

for i  = 1:1:1024
    fprintf(fileID1,'%d\n',dig_in(i));
    fprintf(fileID2,'%d\n',dig_out(i));
    fprintf(fileID3,'%d',bit(i,:));
    fprintf(fileID3,'\n');
end
fclose(fileID1);
fclose(fileID2);
fclose(fileID3);