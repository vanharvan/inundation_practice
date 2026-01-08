% comcot_plot_init
function comcot_mplot_bath_inundation(layerid,caxv,xpos,ypos)
% including boundary of the smaller grid
% caxv: values for caxis
if nargin < 2
    caxv=[-320 1280];
    disp('using defautl values for caxis of [-320 1280]');
end
if nargin <4
    xpos = .97;
    ypos = [.5 .9];
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
save(['layer',layerid,'.mat'], 'x', 'y', 'mat')
mat=-mat;

figure
m_proj('miller','long',[min(x) max(x)],'lat',[min(y) max(y)]);
set(gcf,'color','w')   % Set background colour before m_image call
m_pcolor(x,y,mat'); shading flat
hold on
m_grid('box','fancy');
colormap([m_colmap('blues',32);m_colmap('gland',128)]);   % Colormap sizes chosen because...
                                                          % ... 32/128 = (300+2)/(1210-2)
ax=m_contfbar(xpos,ypos,caxv,[caxv(1):100:caxv(2)],'edgecolor','none','endpiece','no');
xlabel(ax,'meters','color','k');

%saveas(gcf,['bath_inundation_mplot_',layerid,'.fig'])
print(gcf,'-djpeg','-r300',['bath_inundation_mplot_',layerid,'.jpg'])

