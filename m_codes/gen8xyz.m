clear;clc;
% Set base directory
working_dir = pwd;
    addpath(working_dir);
base_dir = fullfile(working_dir, 'comcot_run');
    addpath(base_dir);

% Set output directory
%output_dir = '\\wsl.localhost\ubuntu\home\mharvan\gmt6\zmax_banda'
output_dir = 'output_xyz_ttt'; %change output folder name
if ~isfolder(fullfile(working_dir, output_dir))
    mkdir(fullfile(working_dir, output_dir));
end

list_file = fullfile(working_dir, 'scenario.txt'); % name of txt file containing folder name

fid = fopen(list_file, 'r');
folder_names = {};
tline = fgetl(fid);
while ischar(tline)
    folder_names{end+1} = strtrim(tline);
    tline = fgetl(fid);
end
fclose(fid);

% Loop through each folder
for i = 1:length(folder_names)
    folder_name = folder_names{i};
    folder_path = fullfile(base_dir, folder_name);
    
    if ~isfolder(folder_path)
        fprintf('Skipping missing folder: %s\n', folder_path);
        continue;
    end
    
    data_file = fullfile(folder_path, 'ttt_layer01.dat'); % change input data
    x_file = fullfile(folder_path, 'layer01_x.dat');
    y_file = fullfile(folder_path, 'layer01_y.dat');

    sanitized_name = regexprep(folder_name, '\s+', '_');
    fname_out = fullfile(output_dir, sanitized_name);

    fprintf('---\nProcessing: %s\n', folder_name);

    % Run the main function
    main_comcot2xyz(data_file, x_file, y_file, fname_out);
end
