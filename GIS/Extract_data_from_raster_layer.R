extract_raster_data <- function(layer, points, output, rename = "No"){
  #load required package
  package_required <- c("raster",  "stringr", "readr", "dplyr")
  lapply(package_required, library,  character.only = TRUE)
  
  #load layers
  raster_layer <- list.files(layer, pattern =".tif$", full.names=TRUE)
  #load points
  points_utm <- read_csv(points, 
                         col_types = cols("character", "numeric", "numeric"))
  #ouput address
  output <- output
  
  #stack raster of all input
  raster_layer_stack<- stack(raster_layer)
  
  # Read point, convert them into spatial points
  coordinates(points_utm)= ~ Longitude+ Latitude
  
  # Extract raster value by points
  raster_value=extract(raster_layer_stack, points_utm)
  
  # combine raster with point and extract data frame and csv
  value_points <- as.data.frame(cbind(points_utm,raster_value))
  
  if(rename == "No"){
    #write csv
    write.table(value_points,file=paste(output, "value_points.csv",sep=""),
                append=FALSE, sep= ",", row.names = FALSE, col.names=TRUE)
    
    return(print("File was saved in output address without editing columns name"))
    
  }
  if(rename != "No"){
    warning("you may receive error, you have to update function values in \nline 37, 38 and 39 according your raste leyer")
    
    #Edit column names
    raster_colnames <- c(colnames(value_points))
    raster_colnames  <- raster_colnames[2:4]
    new_name <- str_extract(raster_colnames, "_\\d\\d\\_\\d\\d\\d\\d")
    new_name <- paste("tas", new_name, sep = "")
    value_points <- value_points %>% 
      rename_at(vars(all_of(raster_colnames)), ~ new_name)
    
    #write csv
    write.table(value_points,file=paste(output, "value_points_columns_name_edited.csv",sep=""),
                append=FALSE, sep= ",", row.names = FALSE, col.names=TRUE)
    return(print("File was saved in output address"))
  }
  
}






