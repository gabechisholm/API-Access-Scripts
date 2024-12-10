## api_epc.R
# Energy Performance Certificates
API Name	|EPC Domestic Energy API
Purpose	|Provides energy performance data for domestic properties in specified local authorities
API Type	|REST API
Access Method	|cURL via R script
Base URL	|https://epc.opendatacommunities.org/api/v1/domestic/search
Supported Methods	|GET
Authentication	|Basic Authentication(Authorization: Basic <token>)
Headers Required	|-	Accept: text/csv
-	Authorization: Basic <token>
Request Format	Query Parameters: Append parameters to the base URL (e.g. [local-authority], [size], [search-after]).
Query Parameters	-	local-authority (required): Specify the local authority (e.g. E06000001)
-	size (optional): Maximum number of records per page (default 25, max 5000)
-	search-after (optional): Token for fetching the next page of results (used for pagination)


## api_cdrc.R
Replace **USERNAME** and **PASSWORD** with your actual credentials

Please see: https://epc.opendatacommunities.org/docs/api/domestic#domestic-local-authority for further detail on filling in **line 4**

