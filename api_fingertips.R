library(fingertipsR)
library(parallel)
library(tidyverse)
library(lubridate)

# Set working directory
setwd("C:\\Users\\RNSMGC\\Downloads\\data temp")
all_indicators <- indicators()

# Define the string to search for in the IndicatorName
search_string <- "reading" # Replace this with your actual search string. A rogue period may appear between "search_string" and this comment. Remove it to prevent errors :)
selected_indicators <- all_indicators %>%
  filter(str_detect(IndicatorName, regex(paste0(".*", search_string, ".*"), ignore_case = TRUE)))

indicator_ids <- selected_indicators$IndicatorID

# Define the list of AreaTypeIDs and AreaNames
area_types <- list(c(502,"Stockton-on-Tees"),
                   c(502, "Darlington"),
                   c(502, "Hartlepool"),
                   c(502, "Middlesbrough"),
                   c(502, "Redcar and Cleveland"),
                   c(6, "North East region (statistical)"),
                   c(15, "England"))
# Get data
get_data_for_indicator <- function(indicator_id, area_type_id, area_name) {
  data <- fingertips_data(IndicatorID = indicator_id, AreaTypeID = area_type_id)
  filtered_data <- data %>%
    filter(AreaName == area_name)
  return(filtered_data)
}

# Initialise parallel processing
num_cores <- detectCores() - 1
cl <- makeCluster(num_cores)
clusterEvalQ(cl, {
  library(fingertipsR)
  library(tidyverse)
})
clusterExport(cl, c("fingertips_data", "get_data_for_indicator"))

# Write data 
data_list <- list()
for (area_type in area_types) {
  data_list[[paste(area_type[2], collapse = "_")]] <- parLapply(cl, indicator_ids, get_data_for_indicator, area_type_id = area_type[1], area_name = area_type[2])
}
stopCluster(cl)


# Create new folder
folder_name <- paste0(search_string, "_", Sys.Date(), "_data")
dir.create(folder_name)

# Write to .csv 
for (name in names(data_list)) {
  data_to_write <- do.call(rbind, data_list[[name]])
  write.csv(data_to_write, file.path(folder_name, paste0(name, "_data.csv")))
}
# Final destination message
cat("The data has been successfully written to .csv files in the folder: ", folder_name, "\n")
