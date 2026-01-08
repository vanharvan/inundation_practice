function fp = mw2fault_blaser(magnitude)
if nargin < 2, miu=4*10^10; end

% mw2fault_blaser(magnitude)
% input
% magnitude: moment magnitude Mw
% output
% fl: fault length in km
% wd: fault width in km
% are: fault area in km2
% mo: seismic moment in Nm
% blaser scaling relation for reverse fault (orthogonal)
fl=10^(-2.37+(0.57*magnitude)); %
wd=10^(-1.86+(0.46*magnitude));
area=fl*wd;
mo = 10^((3/2 * magnitude) + 9.05);
slip = mo / (area * 1e6 * miu);

fp.fl = fl;
fp.wd = wd;
fp.area = area;
fp.mo = mo;
fp.slip = slip;


