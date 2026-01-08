%%
data=load('../tide_filter/56001.dat');
hold on
plot(data(:,1)/60,data(:,2)/100,'k');

%%
data=load('../tide_filter/Padang.dat');
hold on
plot(data(:,1)/60,data(:,2)/100,'k');