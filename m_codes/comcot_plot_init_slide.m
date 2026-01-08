% comcot_plot_init
function comcot_plot_init_slide(layerid)
% layerid: 01, 02 and so on
x=load(['ini_slide',layerid,'_x.dat']);
y=load(['ini_slide',layerid,'_y.dat']);
nx = length(x);
ny = length(y);

% displacement z
fid = fopen(['ini_slide',layerid,'.dat']);
a = fscanf(fid,'%g',inf); % write all data into a column of matrix a.
fclose(fid);
initmat = reshape(a,nx,ny);
% bathymetry 
% layerid: 01, 02 and so on
xb=load(['layer',layerid,'_x.dat']);
yb=load(['layer',layerid,'_y.dat']);
nxb = length(xb);
nyb = length(yb);
fid = fopen(['layer',layerid,'.dat']);
a = fscanf(fid,'%g',inf); % write all data into a column of matrix a.
fclose(fid);
mat = reshape(a,nxb,nyb);

figure
pcolor(x,y,initmat');shading flat
hold on
contour(xb,yb,mat',[0 0],'k')
saveas(gcf,['init_',layerid,'.fig'])
print(gcf,'-djpeg','-r300',['init_',layerid,'.jpg'])

