% comcot_plot_init
function comcot_plot_ts(stationid)
% layerid: 01, 02 and so on
load time.dat
ts=load(['ts_record',stationid,'.dat']);

figure
subplot(3,1,1)
plot(time/3600,ts(:,1))
title('Amplitude, m')
subplot(3,1,2)
plot(time/3600,ts(:,2))
title('Speed -X, m/s')
subplot(3,1,3)
plot(time/3600,ts(:,3))
title('Speed -Y, m/s')
xlabel('Time, hr')

saveas(gcf,['ts_',stationid,'.fig'])
print(gcf,'-djpeg','-r300',['ts_',stationid,'.jpg'])

