% comcot_plot_init
function comcot_mplot_bath(layerid,caxv)
% caxv: values for caxis
if nargin < 2 
    caxv=[-6000 0];
    disp('using defautl values for caxis of [-6000 0]');
 end
% layerid: 01, 02 and so on
x=load(['layer',layerid,'_x.dat']);
y=load(['layer',layerid,'_y.dat']);
nx = length(x);
ny = length(y);

fid = fopen(['layer',layerid,'.dat']);
a = fscanf(fid,'%g',inf); % write all data into a column of matrix a.
fclose(fid);
mat = reshape(a,nx,ny);
save layer01.mat x y mat

mat = -mat;
figure
ax=m_contfbar(.97,[.5 .9],caxv,[caxv(1):10:caxv(2)],'edgecolor','none','endpiece','no');
xlabel(ax,'meters','color','k');

m_proj('miller','long',[min(x) max(x)],'lat',[min(y) max(y)]);
set(gcf,'color','w')   % Set background colour before m_image call
m_pcolor(x,y,mat'); shading flat   
caxis(caxv);
colormap(flipud([flipud(m_colmap('blues',10));m_colmap('jet',118)]));
m_gshhs_i('patch',[.8 .8 .8]);
m_grid('box','fancy');



saveas(gcf,['bath_mplot_',layerid,'.fig'])
print(gcf,'-djpeg','-r300',['bath_mplot_',layerid,'.jpg'])

