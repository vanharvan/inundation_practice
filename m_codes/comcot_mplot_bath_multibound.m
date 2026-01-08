% comcot_plot_init
function comcot_mplot_bath_multibound(layerid,layerids,caxv)
% including boundary of the smaller grid
% caxv: values for caxis
if nargin < 3
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
save([layerid,'.mat'], 'x', 'y', 'mat')

mat = -mat;
figure
m_proj('miller','long',[min(x) max(x)],'lat',[min(y) max(y)]);
set(gcf,'color','w')   % Set background colour before m_image call
m_pcolor(x,y,mat'); shading flat
hold on
if strcmp(layerid,'01')
    m_gshhs_l('patch',[.8 .8 .8]);
else
    m_gshhs_h('patch',[.8 .8 .8]);
end

caxis(caxv);
for i = 1 : length(layerids)
    layerid2 = layerids{i};
    x=load(['layer',layerid2,'_x.dat']);
    y=load(['layer',layerid2,'_y.dat']);
    
    
    m_plot([min(x) max(x) max(x) min(x) min(x)],...
        [min(y) min(y) max(y) max(y) min(y)], 'k');
    m_text(min(x),max(y),['Layer',layerid2],'VerticalAlignment','bottom')
end

m_grid('box','fancy');
colormap(flipud([flipud(m_colmap('blues',10));m_colmap('jet',118)]));
ax=m_contfbar(.97,[.5 .9],caxv,[caxv(1):10:caxv(2)],'edgecolor','none','endpiece','no');
xlabel(ax,'meters','color','k');

%saveas(gcf,['bath_bound_mplot_',layerid,'.fig'])
print(gcf,'-djpeg','-r300',['bath_bound_mplot_',layerid,'.jpg'])

