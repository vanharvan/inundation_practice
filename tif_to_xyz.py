import os
from osgeo import gdal

# --- Configuration ---
input_demnas = 'batimetri/DEMNAS_MSL.tif'
temp_demnas_xyz = 'batimetri/DEMNAS_TEMP.xyz'
final_demnas_xyz = 'batimetri/DEMNAS_MSL.xyz'
input_batnas = 'batimetri/BATNAS.tif'
temp_batnas_xyz = 'batimetri/BATNAS_TEMP.xyz'
final_batnas_xyz = 'batimetri/BATNAS_MSL.xyz'

# set boundary
xmin, xmax = 134.02, 134.20
ymin, ymax = -0.95, -0.75
boundaries = [xmin, ymax, xmax, ymin]

print(f"Processing area: {boundaries}")

gdal.Translate(temp_demnas_xyz, input_demnas, format='XYZ', projWin=boundaries)

with open(temp_demnas_xyz, 'r') as infile, open(final_demnas_xyz, 'w') as outfile:
    for line in infile:
        parts = line.split()
        z_value = float(parts[2])
        if z_value >= 0:
            outfile.write(line)
print(f"Output Demnas .xyz file: {final_demnas_xyz}")


gdal.Translate(temp_batnas_xyz, input_batnas, format='XYZ', projWin=boundaries)

with open(temp_batnas_xyz, 'r') as infile, open(final_batnas_xyz, 'w') as outfile:
    for line in infile:
        parts = line.split()
        z_value = float(parts[2])
        if z_value < 0:
            outfile.write(line)
print(f"Output Batnas .xyz file: {final_batnas_xyz}")

os.remove(temp_demnas_xyz)
os.remove(temp_batnas_xyz)