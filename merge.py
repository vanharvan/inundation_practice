import os
import numpy as np
from osgeo import gdal, ogr, osr

gdal.UseExceptions()

# --- Configuration ---
batnas_xyz = "./batimetri/BATNAS_MSL.xyz"
demnas_xyz = "./batimetri/DEMNAS_MSL.xyz"
output_tif = "./batimetri/FINAL_COMBINED_TOPO_BATHY.tif"

# set boundary
xmin, xmax = 134.02, 134.20
ymin, ymax = -0.95, -0.75
boundaries = [xmin, ymax, xmax, ymin] # [ulx, uly, lrx, lry]

# set resolution (in degrees)
res = 0.0004166666667

#Combining DEMNAS-BATNAS xyz
print("Loading XYZ files into memory...")
data_bat = np.loadtxt(batnas_xyz)
data_dem = np.loadtxt(demnas_xyz)
all_points = np.vstack((data_bat, data_dem))
mask = (all_points[:,0] >= xmin) & (all_points[:,0] <= xmax) & \
       (all_points[:,1] >= ymin) & (all_points[:,1] <= ymax)
filtered_points = all_points[mask]
print(f"Total points to interpolate: {len(filtered_points)}")

mem_driver = ogr.GetDriverByName("Memory")
mem_ds = mem_driver.CreateDataSource("mem_ds")
srs = osr.SpatialReference()
srs.ImportFromEPSG(4326)
layer = mem_ds.CreateLayer("points", srs, ogr.wkbPoint25D)
layer.CreateField(ogr.FieldDefn("Z", ogr.OFTReal))

for i in range(len(filtered_points)):
    feat = ogr.Feature(layer.GetLayerDefn())
    feat.SetField("Z", float(filtered_points[i, 2]))
    pt = ogr.Geometry(ogr.wkbPoint25D)
    pt.AddPoint(float(filtered_points[i, 0]), float(filtered_points[i, 1]), float(filtered_points[i, 2]))
    feat.SetGeometry(pt)
    layer.CreateFeature(feat)
    feat = None

width = int((xmax - xmin) / res) + 1
height = int((ymax - ymin) / res) + 1

print(f"Interpolating {width}x{height} grid. This may take a minute...")

gdal.Grid(
    output_tif,
    mem_ds,
    format='GTiff',
    width=width,
    height=height,
    outputBounds=boundaries,
    outputSRS='EPSG:4326',
    algorithm=f'linear:radius=0.002', 
    zfield="Z",
    outputType=gdal.GDT_Float32
)

# Cleanup
mem_ds = None

print(f"Output: {output_tif}")
