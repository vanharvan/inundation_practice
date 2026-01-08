clc; clear;

baseFolder = 'D:\banda_ttt\comcot_run';
outputFile = 'D:\banda_ttt\scenario.txt';

% list all subdirectories in the base folder
items = dir(baseFolder);
subDirs = items([items.isdir] & ~ismember({items.name}, {'.', '..'}));

% write file
fid = fopen(outputFile, 'w');

for i = 1:length(subDirs)
    fprintf(fid, '%s\n', subDirs(i).name);
end

fclose(fid);

fprintf('Found %d scenarios. Saved to %s\n', length(subDirs), outputFile);
