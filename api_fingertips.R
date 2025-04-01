library(fingertipsR)
library(parallel)
library(tidyverse)
setwd("YOUR-DESIRED-FILEPATH") # !!Requires \\ instead of \ in filepath!!
all_indicators <- indicators()
# Define the string to search for in the IndicatorName
search_string <- "smok"  # Replace this with your actual search string. A rogue period will appear between string and comment. Remove this :)
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
get_data_for_indicator <- function(indicator_id, area_type_id, area_name) {
  data <- fingertips_data(IndicatorID = indicator_id, AreaTypeID = area_type_id)
  filtered_data <- data %>%
    filter(AreaName == area_name)
  return(filtered_data)
}
num_cores <- detectCores() -1
cl <- makeCluster(num_cores)
clusterEvalQ(cl,{
  library(fingertipsR)
  library(tidyverse)
})
clusterExport(cl, c("fingertips_data", "get_data_for_indicator"))
data_list <- list()
for (area_type in area_types) {
  data_list[[paste(area_type[2], collapse = "_")]] <- parLapply(cl, indicator_ids, get_data_for_indicator, area_type_id = area_type[1], area_name = area_type[2])
}
stopCluster(cl)
for (name in names(data_list)) {
  data_to_write<-do.call(rbind,data_list[[name]])
  write.csv(data_to_write, paste0(name,"_data.csv"))
}
print("The data has been successfully written to .csv files.")
