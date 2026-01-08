% comcot_plot_init
function comcot_plot_init(layerid)
% layerid: 01, 02 and so on
x=load(['layer',layerid,'_x.dat']);
y=load(['layer',layerid,'_y.dat']);
nx = length(x);
ny = length(y);

% displacement z
if layerid=='01'
fid = fopen(['ini_surface.dat']);
else
fid = fopen(['ini_surface_layer',layerid,'.dat']);
end
a = fscanf(fid,'%g',inf); % write all data into a column of matrix a.
fclose(fid);
initmat = reshape(a,nx,ny);
% bathymetry 
fid = fopen(['layer',layerid,'.dat']);
a = fscanf(fid,'%g',inf); % write all data into a column of matrix a.
fclose(fid);
mat = reshape(a,nx,ny);

figure
pcolor(x,y,initmat');shading flat
hold on
contour(x,y,mat',[0 0],'k')
colorbar
saveas(gcf,['init_',layerid,'.fig'])
print(gcf,'-djpeg','-r300',['init_',layerid,'.jpg'])

