% Plot Tidal Gauge Measurements; 

% file: Tidal Gauge Measurements downloaded from NOAA
% T0: a specified starting time of Earthquake: T0 = 'yyyymmddhhmmss';
%     for Samoa Earthquake: T0 = '20090929174810';

%Created on September 30 2010 (Xiaoming Wang, GNS)

%example: plot_TidalGauge('Gauge_owen_A_2010.058','20090929174810')

function plot_TidalGauge(file,T0)


[tt,tz] = Process_TidalGauge (file,T0);
plot(tt/3600,tz,'k')
xlabel('Time (hours after Earthquake)')
ylabel('Water Elevation (m)')
title('Filtered Tidal Gauge Measurement')
