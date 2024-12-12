# Replace "local-authority" with your desired local authority. Default is Hartlepool. 
library(curl)
base_url <- "https://epc.opendatacommunities.org/api/v1/domestic/search?local-authority=E06000001&size=5000"
auth_header <- "Basic ATTACH-TOKEN-HERE"
# Function to fetch a single page
fetch_page <- function(url, auth_header) {
  handle <- new_handle()
  handle_setheaders(handle,
                    "Accept" = "text/csv",
                    "Authorization" = auth_header
  )
  response <- curl_fetch_memory(url, handle)
  headers <- parse_headers_list(rawToChar(response$headers))
  next_search_after <- headers[["x-next-search-after"]]
  data <- rawToChar(response$content)
  list(data = data, next_token = next_search_after)
}
# Initialize Pagination
current_url <- base_url
all_data <- list()
page <- 1
repeat {
  cat(sprintf("Fetching page %d: %s\n", page, current_url))
  result <- fetch_page(current_url, auth_header)
  all_data[[page]] <- read.csv(text = result$data, stringsAsFactors = FALSE)
  if (is.null(result$next_token)) break
  current_url <- paste0(base_url, "&search-after=", result$next_token)
  page <- page + 1
}
# Standardize the `lmk.key` column
all_data <- lapply(all_data, function(df) {
  if ("lmk.key" %in% colnames(df)) {
    df$lmk.key <- as.character(df$lmk.key)  # Convert to character
  }
  df
})
combined_data <- do.call(rbind, all_data)
View(combined_data)
