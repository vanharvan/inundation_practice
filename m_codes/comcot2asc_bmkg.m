function comcot2asc()

%created by Division of Earthquake and Tsunami Mitigation BMKG
%date : 25 June 2021

data_file = input('Input COMCOT data file name:');
x_file = input('Input X Coordinate file name (e.g.,layer##_x.dat):');
y_file = input('Input Y Coordinate file name (e.g.,layer##_y.dat):');
fname_out = input('Output data file name:');

disp('Loading Data into Memory...')
layer_x = load(x_file);
layer_y = load(y_file);

nx = length(layer_x);
ny = length(layer_y);
xmin = min(layer_x);
ymin = min(layer_y);

dx = (layer_x(nx)-layer_x(1))/nx;
dy = (layer_y(ny)-layer_y(1))/ny;

cellsize = 0.5*(dx+dy);

fid = fopen(data_file);
a = fscanf(fid,'%g',inf); 
fclose(fid);

layer = reshape(a,nx,ny);

max2 = layer';
b = flipud(max2);
b(b <= 0) = -999;

fid = fopen([fname_out,'.asc'],'wt');
fprintf(fid, 'ncols %d \n',nx);
fprintf(fid, 'nrows %d \n',ny);
fprintf(fid, 'xllcorner %.10f \n',xmin);
fprintf(fid, 'yllcorner %.10f \n',ymin);
fprintf(fid, 'Cellsize %.10f \n',cellsize);
fprintf(fid, 'Nodata_value -999.0000000000\n');
for ii = 1:size(b,1)
    fprintf(fid,'%.10f \t',b(ii,:));
    fprintf(fid,'\n');
end
fclose(fid)