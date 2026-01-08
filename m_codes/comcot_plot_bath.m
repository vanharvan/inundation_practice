% comcot_plot_init
function comcot_plot_bath(layerid)
% layerid: 01, 02 and so on
x=load(['layer',layerid,'_x.dat']);
y=load(['layer',layerid,'_y.dat']);
nx = length(x);
ny = length(y);

fid = fopen(['layer',layerid,'.dat']);
a = fscanf(fid,'%g',inf); % write all data into a column of matrix a.
fclose(fid);
mat = reshape(a,nx,ny);


figure
pcolor(x,y,mat');shading flat
colorbar
hold on
contour(x,y,mat',[0 0],'k')
saveas(gcf,['bath_',layerid,'.fig'])
print(gcf,'-djpeg','-r300',['bath_',layerid,'.jpg'])