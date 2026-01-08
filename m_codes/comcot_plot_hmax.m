function [x,y,maxmat,mat] = comcot_plot_zmax(layerid,timeid)
if nargin<2
    timeid='';
end
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
dc=1000;
if min(mat(:))>-500
    dc=10;
elseif min(mat(:))>-1000
    dc=50;
elseif min(mat(:))>-2000
    dc=100;
elseif min(mat(:))>-4000
    dc=1000;    
end
% maximum
fid = fopen(['hmax_layer',layerid,timeid,'.dat']);
a = fscanf(fid,'%g',inf); % write all data into a column of matrix a.
fclose(fid);
maxmat = reshape(a,nx,ny);

cmax=max(maxmat(:))/2;
%%
figure
load parulaz.mat
pcolor(x,y,maxmat');shading flat
caxis([0 cmax])
hc=colorbar;
ylabel(hc,'Amplitude, m')
colormap(mycmap)
hold on
[C,h] = contour(x,y,mat',[-8000:dc:0]);
set(h,'LineColor',[0.5 0.5 0.5]);
axis image
set(gca,'layer','top')  
title('Maximum tsunami Flowdepth')
saveas(gcf,['max_',layerid,'.fig'])
print(gcf,'-djpeg','-r300',['max_',layerid,'.jpg'])

save zmax.mat maxmat x y
save bathmat.mat mat x y

