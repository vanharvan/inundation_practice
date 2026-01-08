clear;
clc;

scenarioFile = 'scenario.txt';

fileID = fopen(scenarioFile, 'r');

if fileID == -1
    error(['Failed to open ' scenarioFile '.']);
end
dirList = textscan(fileID, '%s');

fclose(fileID);

subDirs = dirList{1};
currentDir = pwd;
baserunDir = fullfile(currentDir, 'comcot_run');

for i = 1:length(subDirs)
    subdirName = subDirs{i};
    fullPath = fullfile(baserunDir, subdirName);
    
    if isfolder(fullPath)
        fprintf('Processing directory: %s\n', fullPath);
        cd(fullPath);        
        
        status = system('comcot.exe');
        
        if status ~= 0
            warning('comcot.exe failed in directory: %s', subdirName);
        else
            fprintf('simulation completed successfully in: %s\n', subdirName);
        end
    else
        warning('Directory does not exist: %s', subdirName);
    end

    cd(baserunDir);
end