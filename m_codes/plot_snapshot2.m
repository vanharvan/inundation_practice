%This script is used to plot snapshot data created by COMCOT

% Created on Mar 18, 2014 (Xiaoming Wang, GNS)


function plot_snapshot2(fz,fh,fx,fy)

% Set colour scale here in meters
cc = 20;

layer_x = load(fx);
layer_y = load(fy);
nx = length(layer_x);
ny = length(layer_y);
[x,y] = meshgrid(layer_x,layer_y);

%set the default output range
xs = layer_x(1);
ys = layer_y(1);
xe = layer_x(nx);
ye = layer_y(ny);

% Load snapshot Data
fid = fopen(fz);
layer = fscanf(fid,'%g',inf); 
fclose(fid);
z = reshape(layer,nx,ny);
clear layer

% Load dem Data
fid = fopen(fh);
layer = fscanf(fid,'%g',inf); 
fclose(fid);
h = reshape(layer,nx,ny);

% %%Load in base map (for Gisborne Project)
% if i_map == 0
%     disp('Loading Geo-Referenced Image as Base map...')
% %     mapname
% %     tfwname
%     handle = imread(mapname);
%     [image_ny,image_nx,itmp] = size(handle);
%     %get Georeferencing information
%     TFW = load(tfwname);
%     A = TFW(1);
%     B = TFW(2);
%     C = TFW(3);
%     D = TFW(4);
%     E = TFW(5);
%     F = TFW(6);
%     dx = A;
%     dy = D;
%     figure_xs = E;
%     figure_xe = figure_xs+image_nx*dx;
%     figure_ye = F;
%     figure_ys = figure_ye + image_ny*dy;
%     image(handle,'CDataMapping','scaled',...
%             'XData',[figure_xs figure_xe],...
%             'YData',[figure_ye figure_ys]);
% %     set(gca,'YDir','normal')
%     hold on
% %     axis equal
%     axis xy
% %     axis([xs xe ys ye])               
% end


% visualize snapshot data;
pcolor(x,y,z')
hold on
% create coastal line contour
contour(x,y,-h',[0 0],'k');
shading interp
axis equal
axis tight
zmax = max(max(z));
zmin = min(min(z));
% cc = max([abs(zmax) abs(zmin)]);
% cc = 10;
%caxis([zmin zmax])
caxis([-1 1])

colorbar
%colormap(jet(20))
load sediment_cmap.mat
colormap(mycmap)
box on
set(gca,'Layer','top')
% axis([281000 318000 5286000 5312000])
% axis([288000 308000 5294000 5310000])

caption = strrep(fz,'_','\_');
title(caption);


figurename = strrep(fz, '.dat', '');

print('-dpng', [figurename,'.png'],'-r300');

hold off
end




