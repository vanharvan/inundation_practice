% comcot_plot_init
function comcot_plot_ts_records(stationid)
% layerid: 01, 02 and so on
ts=load(['ts_record.dat']);
tsid=stationid+1;
figure
%subplot(3,1,1)
plot(ts(:,1)/3600,ts(:,tsid))
title('Amplitude, m')
xlabel('Time, hr')

saveas(gcf,['ts_',num2str(stationid),'.fig'])
print(gcf,'-djpeg','-r300',['ts_',num2str(stationid),'.jpg'])

