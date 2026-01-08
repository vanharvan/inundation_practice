% PROCESSING TIDAL GAUGE DATA
%
% File: Tidal Gauge Measurements downloaded from NOAA
%       Format/Source:WCATWC unfiltered
%       First 4 lines contain description of dataset and data starts from
%       the 5th line;
%       Column 1                      Column 2    Column 3
%       SampleTime(epochal 1/1/1970)  WaterLevel  SampleTime(yyyymmddhhmmss)
% T0: a specified starting time of Earthquake: T0 = 'yyyymmddhhmmss', UTC;
%     e.g., '20100227063414'

%NOTES:
% Modified from the script made for the simulation work of 2007 Peru Event;
% Updated on September 27 2010 (Xiaoming Wang, GNS)
% Updated on September 30 2010 (Xiaoming Wang, GNS)


function [tt,tz] = Process_TidalGauge (file,T0)

%///////////////////////////////////////////////////////////////////
%Read measurements from Tidal Gauge data file
%///////////////////////////////////////////////////////////////////
disp(['Reading and processing tidal gauge data file:',file])
% data = load(file);

% %Use testread to load datafile;
% data = textread(file,'%s','delimiter','\n','whitespace',' ');
% [nrow,ncol] = size(data);
% data1 = data(5:nrow,:);
% data2 = char(data1);
% data = str2num(data2);
% [nrow,ncol] = size(data)

% Use fopen to load datafile;
fid = fopen(file);
for k = 1:4; fgets(fid); end % Skip the first 4 lines (comments)
tmp = fscanf(fid,'%f',inf);
fclose(fid);
N = length(tmp);
ncol = 3;
nrow = N/ncol;
data = reshape(tmp,ncol,nrow);
data = data';
 

%save temporary backup for checking
save gauge.dat data -ascii;

%///////////////////////////////////////////////////////////////////
%Adjust Time ZERO and spacing
%///////////////////////////////////////////////////////////////////
% Calculate the time lag between the strike time and starting time
% of tidal gauge measurements;
% Assuming time difference is not larger than one month
time0 = num2str(T0,'%14.14i');
% time = num2str(data(1,3),'%14.14i')
time = int2str(data(1,3));

year0 = str2num(time0(1:4));
month0 = str2num(time0(5:6));
day0 = str2num(time0(7:8));
hour0 = str2num(time0(9:10));
minute0 = str2num(time0(11:12));
second0 = str2num(time0(13:14));

year = str2num(time(1:4));
month = str2num(time(5:6));
day = str2num(time(7:8));
hour = str2num(time(9:10));
minute = str2num(time(11:12));
second = str2num(time(13:14));

if year~=year0
    if abs(year-year0)>=2
        disp('Time-matching Problem occurs...')
    else
        if (year>year0 & month==1 & month0==12)
            timelag = ((month-0)*31*24*3600 + day*24*3600 + ...
                        hour*3600 + minute*60 + second) - ...
                      ((month0-12)*31*24*3600 + day0*24*3600 + ...
                        hour0*3600 + minute0*60 + second0);
        elseif (year<year0 & month==12 & month0==1)
            timelag = ((month-12)*31*24*3600 + day*24*3600 + ...
                        hour*3600 + minute*60 + second) - ...
                      ((month0-0)*31*24*3600 + day0*24*3600 + ...
                        hour0*3600 + minute0*60 + second0);
        else
            disp('Time-matching Problem occurs...')
        end
    end
else
if month==month0
    dd = min([day day0]);
    timelag = ((day-dd)*24*3600 + hour*3600 + minute*60 + second) - ...
              ((day0-dd)*24*3600 + hour0*3600 + minute0*60 + second0);
else
    mm = min([month month0]);
    if mm==2
        if mod(year0,4)==0
            timelag = ((month-mm)*29*24*3600 + day*24*3600 + ...
                        hour*3600 + minute*60 + second) - ...
                      ((month0-mm)*29*24*3600 + day0*24*3600 + ...
                        hour0*3600 + minute0*60 + second0);
        else
            timelag = ((month-mm)*28*24*3600 + day*24*3600 + ...
                        hour*3600 + minute*60 + second) - ...
                      ((month0-mm)*29*24*3600 + day0*24*3600 + ...
                        hour0*3600 + minute0*60 + second0);
        end
    elseif mm==4 | mm==6 | mm==9 | mm==11
        timelag = ((month-mm)*30*24*3600 + day*24*3600 + ...
                      hour*3600 + minute*60 + second) - ...
                  ((month0-mm)*29*24*3600 + day0*24*3600 + ...
                      hour0*3600 + minute0*60 + second0);
    else
        timelag = ((month-mm)*31*24*3600 + day*24*3600 + ...
                      hour*3600 + minute*60 + second) - ...
                  ((month0-mm)*29*24*3600 + day0*24*3600 + ...
                      hour0*3600 + minute0*60 + second0);
    end
end
end

% Adjust the timing against the strike time;
t = (data(:,1) - data(1,1))+timelag;
z = data(:,2);

% Check the data abscissae;
kk = 0;
for nn = 1:10
    kk = 0;
    for k = 2:nrow-1
        if t(k,1)<t(k-1,1)
            t(k,1)=t(k-1,1);
            z(k,1)=z(k-1,1);
            kk = kk+1;
        end
    end
    if kk~=0
        disp('Non-distinct data abscissae found...')
    end
end
% Remove the duplicated data entries;
kk = 0;
for nn = 1:20
    kk = 0;
    for k = 2:nrow-1
        if t(k,1)==t(k-1,1) & t(k,1)~=t(k+1,1)
            t(k,1)=0.5*(t(k-1,1)+t(k+1,1));
            z(k,1)=0.5*(z(k-1,1)+z(k+1,1));
            kk = kk+1;
        end
    end
    if kk~=0
        disp('Duplicated data entries found...')
    end
end

% Resample the measurement data to ensure even-spacing
dt = 15; %resample the sequence data at a resolution of 15 seconds;
tt = (t(1):dt:t(nrow))';
zz = interp1(t,z,tt);

%///////////////////////////////////////////////////////////////////
% Filtering the measurement data to remove Tidal Background
%///////////////////////////////////////////////////////////////////
% Apply low-pass filter to remove tidal background
f = 1/dt;%sampling frequency
fNorm = (1/18000)/(f/2);
[b,a] = butter(4,fNorm,'high');
F = filtfilt(b,a,zz);

% Apply high-pass filter to remove earthquake disturbances
f = 1/dt;%sampling frequency
fNorm = (1/180)/(f/2);
[b,a] = butter(4,fNorm,'low');
F = filtfilt(b,a,F);

tz = F;

