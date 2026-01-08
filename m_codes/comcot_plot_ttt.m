function [x,y,tttmat] = comcot_plot_ttt(layerid, ths)
% ths = thresshold id 
if nargin < 2, ths=1; end

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
% maximum
fid = fopen(['ttt_layer',layerid,'.dat']);
a = fscanf(fid,'%g',inf); % write all data into a column of matrix a.
fclose(fid);
aa=a(1+(ths-1)*nx*ny:nx*ny+(ths-1)*nx*ny);
tttmat = reshape(aa,nx,ny);

cmax=max(tttmat(:)/60);
%%
figure
mycmap=colormap('jet');
mycmap=flipud(mycmap);
pcolor(x,y,(tttmat/60)');shading flat
caxis([0 cmax])
hc=colorbar;
ylabel(hc,'Travel time, min')
colormap(mycmap)
hold on
contour(x,y,mat',[-8000:dc: 0],'color',[.5 .5 .5])
axis image
set(gca,'layer','top')  
title('Tsunami travel time')
%saveas(gcf,['max_',layerid,'.fig'])
print(gcf,'-djpeg','-r300',['ttt_',layerid,'.jpg'])

save ttt.mat tttmat x y
save bathmat.mat mat x y

