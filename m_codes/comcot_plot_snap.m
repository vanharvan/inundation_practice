
function [x,y,snapmat] = comcot_plot_snap(layerid,snaptime)
% layerid: 01, 02 and so on
x=load(['layer',layerid,'_x.dat']);
y=load(['layer',layerid,'_y.dat']);
nx = length(x);
ny = length(y);

% bathymetry
fid = fopen(['layer',layerid,'.dat']);
a = fscanf(fid,'%g',inf); % write all data into a column of matrix a.
fclose(fid);
mat = reshape(a,nx,ny);
% contour interval 
if min(mat(:))>-500
    dc=10;
elseif min(mat(:))>-1000
    dc=50;
elseif min(mat(:))>-8000
    dc=100;
end
% snapshot z
% time id
bst=num2str(1000000+snaptime);
bst2=bst(2:7); % ambil 6 digit terakhir
fid = fopen(['z_',layerid,'_',bst2,'.dat']);
a = fscanf(fid,'%g',inf); % write all data into a column of matrix a.
fclose(fid);
snapmat = reshape(a,nx,ny);

fid = fopen(['m_',layerid,'_',bst2,'.dat']);
m = fscanf(fid,'%g',inf); % write all data into a column of matrix a.
fclose(fid);
snapmmat = reshape(m,nx,ny);

fid = fopen(['n_',layerid,'_',bst2,'.dat']);
n = fscanf(fid,'%g',inf); % write all data into a column of matrix a.
fclose(fid);
snapnmat = reshape(n,nx,ny);

cmax=max(snapmat(:))/2;
%%
figure
load parulaz.mat
pcolor(x,y,snapmat');shading flat
caxis([0 cmax])
colorbar
colormap(mycmap)
hold on
quiver(x(1:10:end),y(1:10:end),...
    snapmmat(1:10:end,1:10:end)',snapnmat(1:10:end,1:10:end)',...
    'r')
contour(x,y,mat',[-8000:dc: 0],'color',[.5 .5 .5])
axis image
set(gca,'layer','top')  
%saveas(gcf,['max_',layerid,'.fig'])
print(gcf,'-djpeg','-r300',['snap_',layerid,'_',bst2,'.jpg'])

