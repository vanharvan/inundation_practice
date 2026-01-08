% plot snapshots
fz='z_01_000000.dat';
fx='layer01_x.dat';
fy='layer01_y.dat';
fh='layer01.dat';
plot_snapshot2(fz,fh,fx,fy)

%%

fx='layer04_x.dat';
fy='layer04_y.dat';
fh='layer04.dat';

dit=99;
for i = 1:60
    ndat=num2str(1000000 + (dit * (i-1)));
    fz=['h_04_',ndat(2:7),'.dat'];
    plot_snapshot2(fz,fh,fx,fy)
end