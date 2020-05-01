clear all
clc


for i  = 1:1:1024
    x(i,:) = bitget(randi(256) - 129,8:-1:1, 'int8');
end

fileID = fopen('test_data_in_bit','w');
for i  = 1:1:1024
    fprintf(fileID,'%d',x(i,:));
    fprintf(fileID,'\n');
end
fclose(fileID);