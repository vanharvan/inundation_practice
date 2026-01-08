load faultcoords.mat
figure
plot3(mf,nf,depth)
ylabel('Lat')
xlabel('Lon')
zlabel('Depth, m')
set(gca, 'Zdir', 'reverse')
