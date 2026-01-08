
function plot_TideMask (id)

%==========================================================================
%This script is used to plot Tide Mask data file, 
% 
%This script is used to plot maximum tsunami wave height distribution.
%This script only works for COMCOT version 1.7, needs modification for
%earlier versions.
%Note: change cmax necessarily to yield a better plot
% Revised on April 21 2008 by Xiaoming Wang
% - revised from the script for earlier versions of comcot;
% updated on August 20 2009 By Xiaoming Wang
% Updated on March 10 2012 (Xiaoming Wang, GNS)
% - Add support on floor deformation adjustment;
% - Add support on processing ghost grids output;
% Updated on April 05 2016 by Xiaoming Wang
% - by default, pcolor function in matlab shades a pixel positioning input  
%   coordinates at its lower-left corner. In contract, the position of 
%   a grid cell in COMCOT is defined at its cell center.
%   In this update, a shift of half a grid size toward lower-left direction   
%   is made to the coordinates files used to colour-shade the grid cell 
%   so that now grid cell center coincedes with pixel center in the color-
%   shading plot.
% - icorner is introduced to control if it is cell-center or cell-corner 
%   registered;
%   icorner = 0: adjust cell-corner convention of matlab to cell-center;
%           = 1: do not adjust matlab's cell-corner registration convention
%==========================================================================

%--------------------------------------------------------------------------
% Pre-dedined values for variable used in this script;
DI_LIMIT = 0.05;
i_xyz_output = 1;
%i_deform = 1;
cmax = 3.0; %change this value to adjust color scale
N = 10; %Number of color levels;
tl = 0.0;
figurename = 'Figure_Zmax';

icorner = 1;
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Input information
fname = input('Input max water level data file name:');
caption = input('Input caption of the plot (figure title):');
des_x = input('Input x label of the plot (description of x axis):');
des_y = input('Input y label of the plot (description of y axis):');
% cmax = input('Please input the color scale:');
i_map = input('Use Georeferenced image as a base map? (0:Yes, 1-No):');
if i_map == 0
    mapname = input('Please input base map name:');
    tfwname = input('Please input TFW (World File) file Name:');
end
i_deform = input('Apply deformation correction? (0-Yes, 1-No):');
i_tide = input('Apply tidal level adjustment? (0-Yes, 1-No):');
if i_tide==0
    tl = input('Please input tidal level:');
end 
icorner = input('Adjust MatLab pixel-corner registration to pixel-center? (0-Yes;1-No):');
if icorner~=0 & icorner~=1
    icorner = 1;
end

i_xyz_output = input('Output Zmax in xyz-format? (0-Yes;1-No):');

if i_xyz_output~=0 & i_xyz_output~=1
    i_xyz_output = 1;
end

icoord = input('Coordinates of input data? (0-Spherical;1-Cartesian):');
if icoord ~= 0
    icoord = 1;
end
%

% fname = 'etamax_layer01.dat'
%load bathymetry data
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Load maximum water level and water depth data;
%%%-----
% check if the input file name contains 'ghost_'
ghost = 'ghost_';
ighost = 0;
ighost = strncmp(fname,ghost,6);

disp('Loading bathymetric/topographical data ...')
str_id = num2str(id,'%2.2i');

% Read x coordinates;
if ighost==1
    fid = fopen(['ghost_layer',str_id,'_x.dat']);
else
    fid = fopen(['layer',str_id,'_x.dat']);
end
layer_x = fscanf(fid,'%g',inf); 
fclose(fid);
% Read y coordinates;
if ighost==1
    fid = fopen(['ghost_layer',str_id,'_y.dat']);
else
    fid = fopen(['layer',str_id,'_y.dat']);
end
layer_y = fscanf(fid,'%g',inf); 
fclose(fid);

% % make a shift of coordinates so that cell center coincedes with pixel
% % center in the colour-shading image;
% layer_x = layer_x - 0.5*(layer_x(2)-layer_x(1));
% layer_y = layer_y - 0.5*(layer_y(2)-layer_y(1));

[x,y] = meshgrid(layer_x,layer_y);
nx = length(layer_x);
ny = length(layer_y);

% Read water depth data;
if ighost==1
    fid = fopen(['ghost_layer',str_id,'.dat']);
else
    fid = fopen(['layer',str_id,'.dat']);
end
a = fscanf(fid,'%g',inf); 
fclose(fid);
h = reshape(a,nx,ny);
clear a

% Load maximum water level data
disp('Loading maximum water level data ...')
fid = fopen(fname);
a = fscanf(fid,'%g',inf); % write all data into a column of matrix a.
fclose(fid);

zmax = reshape(a,nx,ny);
clear a
%--------------------------------------------------------------------------

% % ADDED TEMPORARILY
% h = h - 0.8;
% zmax = zmax + 0.8;

%--------------------------------------------------------------------------
% Apply ground/seafloor deformation adjustment to dem data;
deform = zeros(nx,ny);
dem = h;
%Apply floor deformation if required
if i_deform==0
    disp('Loading deformation data ...')
    if id==1
        fid = fopen(['ini_surface.dat']);
    else
        if ighost==1
        	fid = fopen(['ghost_ini_surface_layer',str_id,'.dat']);
        else
            fid = fopen(['ini_surface_layer',str_id,'.dat']);
        end
    end
    a = fscanf(fid,'%g',inf); 
    fclose(fid);
    deform = reshape(a,nx,ny);
    clear a
    h = h-deform;
end
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
% Pre-process the input data
% zmax = data_trim(zmax,h);
zmax_cellz = 0.0;
zmax_cellx = 0.0;
zmax_celly = 0.0;

zmax_all = zmax;
% for i = 1:nx
%     for j = 1:ny
%         % flow depth without any treatment;
%         dd = h(i,j)+zmax(i,j); 
%         % Still waterdepth in term of MSL after deformation correction;
%         hs = h(i,j); 
% 
%         %maximum water level = 0.0 if flow depth dd<limit and on dry land
%         if dd<DI_LIMIT & hs<=0.0
%             zmax_all(i,j) = 0.0;
%             zmax(i,j) = NaN;
%         end
%         
%         %special treatment if land becomes water after tide adjustment;
%         % Still waterdepth with tidal level adjustment;
%         ht = tl+hs;         
%         if i_tide == 0
%             if h(i,j)<=0.0 & ht>0.0 & abs(tl-zmax(i,j))<=DI_LIMIT            
%                 zmax_all(i,j)=0.0;
%                 zmax(i,j) = NaN;
%             end
%         end
%         if zmax_cellz < zmax(i,j)
%             zmax_cellz = zmax(i,j);
%             zmax_cellx = layer_x(i);
%             zmax_celly = layer_y(j);
%         end
%     end
% end
%set the default output range
xs = layer_x(1);
ys = layer_y(1);
xe = layer_x(nx);
ye = layer_y(ny);
is = 1;
ie = nx;
js = 1;
je = ny;
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Load and display the geo-referenced image as background;
if i_map == 0
    disp('Loading Geo-Referenced Image as background ...')
%     mapname
%     tfwname
    handle = imread(mapname);
    [image_ny,image_nx,itmp] = size(handle);
    %get Georeferencing information
    TFW = load(tfwname);
    A = TFW(1);
    B = TFW(2);
    C = TFW(3);
    D = TFW(4);
    E = TFW(5);
    F = TFW(6);
    dx = A;
    dy = D;
    figure_xs = E;
    figure_xe = figure_xs+image_nx*dx;
    figure_ye = F;
    figure_ys = figure_ye + image_ny*dy;
    image(handle,'CDataMapping','scaled',...
                    'XData',[figure_xs figure_xe],...
                    'YData',[figure_ye figure_ys]);

%     image(handle,'CDataMapping','scaled',...
%             'XData',[figure_xs figure_xe],...
%             'YData',[figure_ye figure_ys]);
    set(gca,'YDir','normal')
    hold on
    axis equal
    axis xy
    axis([xs xe ys ye])   
    hold on
end
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Plot coloured figure for maximum water level distribution;
[x,y] = meshgrid(layer_x,layer_y);
if icorner == 0
    pcolor(x-0.5*(layer_x(2)-layer_x(1)),y-0.5*(layer_y(2)-layer_y(1)),zmax')
else
    pcolor(x,y,zmax')
end
shading interp
% shading flat
axis equal
axis tight
[cmin,cmax] = calc_caxis (zmax); % Colorscale determined from calc_caxis
% % cmin = 0;
% % cmax = 0.15;
% if cmax > 0
% %     contourcmap([0:cmax/20:cmax],'jet','colorbar','on','location','vertical')
%     if nx<1.5*ny
%         contourcmap([0:cmax/N:cmax],'jet','colorbar','on','location','vertical')
%     else
%         contourcmap([0:cmax/N:cmax],'jet','colorbar','on','location','horizontal')
%     end
% end
% if cmax < 0 
% %     contourcmap([0:cmax/20:cmax],'jet','colorbar','on','location','vertical')
%     if nx<1.5*ny
%         contourcmap([cmax:cmax/N:0],'jet','colorbar','on','location','vertical')
%     else
%         contourcmap([cmax:cmax/N:0],'jet','colorbar','on','location','horizontal')
%     end
% end
colorbar;
colormap('jet(10)');
xlabel(des_x)
ylabel(des_y)
figurecaption = strrep(caption,'_','\_');
title(figurecaption)
% mycmap = get(gcf,'Colormap'); 
% save('MyColormaps','mycmap')
% load('MyColormaps','mycmap')
% set(gcf,'Colormap',mycmap)
clear zmax

hold on
if max(max(h))~=min(min(h))
    contour(x,y,-dem',[0 0],'k')
end

if icoord == 0
   Ratio_X2Y = cos(0.5*(layer_y(1)+layer_y(ny))/180*pi);
   set(gca,'DataAspectRatio',[1 1*Ratio_X2Y 1])
end

axis([layer_x(1) layer_x(nx) layer_y(1) layer_y(ny)])
box on
colormapeditor
caxis([0 4])
colormap('jet(4)')
shading flat

% %plot sub-level grid region
% if id == 1
%     plot_region(2)
% end

% caption = strrep(caption,'_','\_');
print('-dpng', [figurename,'_',caption,'_Layer',str_id,'.png'],'-r300');

% /////////////////////////////////////////////////////////////////////////
% display where the maximum elevation appears
hold on
plot(zmax_cellx,zmax_celly,'ro');
disp(['maximum tsunami elevation ',num2str(zmax_cellz),...
        'm at (',num2str(zmax_cellx),',',num2str(zmax_celly),')'])

% /////////////////////////////////////////////////////////////////////////
% save zmax in XYZ-format
if i_xyz_output == 0
disp('Writing maximum water level data into a XYZ-format file ...')
NN = nx*ny;
xyzdata = zeros(NN,3);

iflip = 0;  %iflip = 0: write from south to north; 1 - write data from north to south
if iflip == 1
   dataflip = flipud(zmax_all);
   clear zmax_all
   layer_y = flipud(layer_y);
   for j = 1:ny
       ks = (j-1)*nx+1;
       ke = j*nx;
       xyzdata(ks:ke,1) = layer_x;
       xyzdata(ks:ke,2) = layer_y(j);
       xyzdata(ks:ke,3) = dataflip(1:nx,j);
   end
   clear dataflip
end

if iflip == 0
%    bathymetry(:,3) = a;
    for j = 1:ny
        ks = (j-1)*nx+1;
        ke = j*nx;
        xyzdata(ks:ke,1) = layer_x;
        xyzdata(ks:ke,2) = layer_y(j);
        xyzdata(ks:ke,3) = zmax_all(:,j);
    end
    clear zmax_all
end

%sce_des = strrep(sce_des,'_','\_');
fid = fopen(['TideMask_Layer',num2str(id,'%2.2i'),'.xyz'],'w+');
%write dimension of slide data slide(nx,ny,nt)
%write x coordinates
for i=1:NN
    fprintf(fid,'%f, %f, %f\n',xyzdata(i,1),xyzdata(i,2),xyzdata(i,3));
end
fclose(fid)
end





