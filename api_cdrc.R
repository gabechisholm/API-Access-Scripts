library(cdrcR)
# Replace USERNAME and PASSWORD with your CDRC API login
loginCDRC("USERNAME", "PASSWORD")
imd <- getCDRC("IMD2019", geography = "LADname", geographyCode = c("Hartlepool", "Leeds"))
# Removes "Leeds" as it is not needed
imd_filtered <- imd[!grepl("Leeds", imd$lsoa11NM, ignore.case = TRUE), ]
setwd("YOUR-DESIRED-FILEPATH")
write.csv(imd_filtered, "data.csv")
