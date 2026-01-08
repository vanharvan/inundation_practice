% This script is used to plot tsunami arrival time contours.
% This script only works for COMCOT version 1.7, needs modification for
% earlier versions.

% Created on October 14 2010 (Xiaoming Wang, GNS);

% Updated on Oct 05 2018 (Xiaoming Wang)
% - add support on multiple threshold values for arrival detections


function plot_ttt(id)

num_thresholds = 1; % 1 threshold for arrival detection, by default;

figurename = 'Figure_Tsunami_Arrival_Time_';

fname = input('Input ttt data file name:');
num_thresholds = input('Input total number thresholds used:');
if num_thresholds < 1 
    num_thresholds = 1;
end

i_map = input('Use Georeferenced image as a base map? (0:Yes, 1-No):');
if i_map == 0
    mapname = input('Please input base map name:');
    tfwname = input('Please input TFW (World File) file Name:');
end
caption = input('Please input description of the plot (figure title):');
des_x = input('Input x label of the plots (description of x axis):');
des_y = input('Input y label of the plots (description of y axis):');
t_int = input('Please arrival time contour interval (in seconds):');

%load bathymetry data

str_id = num2str(id,'%2.2i');
% str_id

disp('Loading Bathymetry/topography data ......')
layer = load(['layer',str_id,'.dat']);
layer_x = load(['layer',str_id,'_x.dat']);
layer_y = load(['layer',str_id,'_y.dat']);
[x,y] = meshgrid(layer_x,layer_y);

nx = length(layer_x);
ny = length(layer_y);

depth = reshape(layer,nx,ny);
clear layer

%set the default output range
xs = layer_x(1);
ys = layer_y(1);
xe = layer_x(nx);
ye = layer_y(ny);
is = 1;
ie = nx;
js = 1;
je = ny;

%%Load in base map (for Gisborne Project)
if i_map == 0
    disp('Loading Geo-Referenced Image as Base map...')
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
%    image(handle,'CDataMapping','scaled','XData',[figure_xs figure_xe],'YData',[figure_ye figure_ys]);
end

%Loading arrival time data
disp('Loading tsunami arrival time data ...')
fid = fopen(fname);
a = fscanf(fid,'%g',inf); % write all data into a column of matrix a.
fclose(fid);

ttt_time = reshape(a,nx,ny,num_thresholds);
clear a

for k = 1:num_thresholds
figure(k)    
    
tmax = max(max(ttt_time(:,:,k)))
% tmin = min(min(ttt_time(:,:,k)))
tmin = 0.0;

if t_int<0.00001
    t_int = 3600.0; % one hour interval by default
end

Nt = floor((tmax-tmin)/t_int);

Ns = floor(tmin/t_int);
Ne = floor(tmax/t_int)+1;

v = (Ns:1:Ne)*t_int;

% Convert seconds to minutes
% ttt_time(:,:,k) = ttt_time(:,:,k);%/60;
%v = v/60;

[x,y] = meshgrid(layer_x,layer_y);

% figure(k)

if i_map == 0
    image(handle,'CDataMapping','scaled',...
            'XData',[figure_xs figure_xe],...
            'YData',[figure_ye figure_ys]);
    set(gca,'YDir','normal')
    hold on
    axis equal
    axis xy
    axis([xs xe ys ye])
end

hold on


%[c,h] = contour(x,y,ttt_time(:,:,k)',v,'r');
pcolor(x,y,ttt_time(:,:,k)');

axis equal
axis tight
% if id==1
%     axis([165 169.5 -49.5 -45])
% end
xlabel(des_x)
ylabel(des_y)
title(caption)
% contour(x,y,ttt_time(:,:,k)',[30 30],'k');
% clabel(c,h,'manual','Color','w')
% clabel(c,h,'Color','r')

hold on
contour(x,y,-depth',[0 0],'k') %comment this line if no shorelines needed
axis([layer_x(1) layer_x(nx) layer_y(1) layer_y(ny)])
box on


% %plot sub-level grid region
% if id == 1
%     plot_region(2)
% end


% 
% if id == 1
%     axis([560000 670000 5650000 5780000])
% end

%PLOT BARS
% plot_obs()
% plot_obs1()
% axis([550000 680000 5650000 5780000])
%------------------------------------------
%plot figure
print('-dpng', [figurename,'_',caption,'_Layer',str_id,'_',num2str(k,'%2.2i')],'-r300');
hold off
end




