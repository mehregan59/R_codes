This function extract data from raster layer (tiff). You must have UTM points (csv file) to extract data. If you want to edit columns name after extraction you can add rename = “Yes” to the function but you need to edit line 37-39 in function according your raster layer. 
I provided test folder that contains raster layers in tiff and points as csv file. 


For example you can run these cod with example files after loading function

layer= "D:/GIS/test/"
points = "D:/GIS/test/points_utm.csv"
output = "D:/GIS/test/"

#without editing column name
extract_raster_data(layer, points, output) 
#or with editing column name
extract_raster_data(layer, points, output, rename = "Yes")  
