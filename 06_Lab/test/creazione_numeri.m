clear all
clc


for i  = 1:1:1024
    x(i) = randi(256) - 129;
end

fileID = fopen('test_data_in','w');
fprintf(fileID,'%d\n',x);
fclose(fileID);