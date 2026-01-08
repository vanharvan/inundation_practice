import os
from osgeo import gdal
import numpy as np

input_raster = './batimetri/DEMNAS_3015-21_v1.0.tif'
msl_raster = './MODEL_PASUT/MSL.tif'
output_raster = './batimetri/DEMNAS_MSL.tif'
temp_msl = 'MSL_TEMP.tif'

ds_input = gdal.Open(input_raster)
gt = ds_input.GetGeoTransform()
res_x = gt[1]
res_y = abs(gt[5])
print(f"Input Raster Resolution: {res_x} x {res_y}")

width = ds_input.RasterXSize
height = ds_input.RasterYSize
print(f"Input Raster Size: {width} x {height}")

min_x = gt[0]
max_y = gt[3]
max_x = min_x + (width * res_x)
min_y = max_y - (height * res_y)
print(f"Processing Area: Lon {min_x:.4f} to {max_x:.4f}, Lat {min_y:.4f} to {max_y:.4f} ")

#regrid MSL Model to processing area and resolution
gdal.Warp(
    temp_msl, 
    msl_raster, 
    outputBounds=[min_x, min_y, max_x, max_y], 
    xRes=res_x, 
    yRes=res_y,
    resampleAlg='cubicspline'
)

ds_msl = gdal.Open(temp_msl)
band_a = ds_input.GetRasterBand(1).ReadAsArray()
band_b = ds_msl.GetRasterBand(1).ReadAsArray()
corrected_data = band_a - band_b

#assign nodata to negative values
nodata_value = -9999
corrected_data[corrected_data < 0] = nodata_value

driver = gdal.GetDriverByName('GTiff')
out_ds = driver.Create(output_raster, width, height, 1, gdal.GDT_Float32)
out_ds.SetGeoTransform(gt)
out_ds.SetProjection(ds_input.GetProjection())
out_ds.GetRasterBand(1).WriteArray(corrected_data)

out_ds = None
ds_input = None
ds_msl = None

if os.path.exists(temp_msl):
    os.remove(temp_msl)

print(f"Result saved as: {output_raster}")