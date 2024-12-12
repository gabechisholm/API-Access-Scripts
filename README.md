# Table of Contents
- [CDRC API](#consumer-data-research-centre-cdrc)
- [EPC API](#energy-performance-certificates-epc)
- [LGInform API](#local-government-inform-lginform)

---

# Energy Performance Certificates (EPC)
## api_epc.R
| **API Name**         | EPC Domestic Energy API                                                                                  |
|-----------------------|---------------------------------------------------------------------------------------------------------|
| **Purpose**          | Provides energy performance data for domestic properties in specified local authorities                 |
| **API Type**         | REST API                                                                                                |
| **Access Method**    | cURL via R script                                                                                       |
| **Base URL**         | [https://epc.opendatacommunities.org/api/v1/domestic/search](https://epc.opendatacommunities.org/api/v1/domestic/search) |
| **Supported Methods**| GET                                                                                                     |
| **Authentication**   | Basic Authentication (`Authorization: Basic <token>`)                                                  |
| **Headers Required** | - `Accept: text/csv`<br>- `Authorization: Basic <token>`                                                |
| **Request Format**   | Query Parameters: Append parameters to the base URL (e.g., `[local-authority]`, `[size]`, `[search-after]`). |
| **Query Parameters** | - `local-authority` (required): Specify the local authority (e.g., `E06000001`)                         |
|                       | - `size` (optional): Maximum number of records per page (default 25, max 5000)                         |
|                       | - `search-after` (optional): Token for fetching the next page of results (used for pagination)          |
| **Response Format**  | Comma Separated Values (CSV)                                                                            |
| **Pagination Details**| - Uses the `X-Next-Search-After` header in the response.<br>- Include `search-after=<token>` in subsequent requests to fetch additional pages. |
| **Rate Limits**       | 5000 rows per request – unlimited* requests                                                            |
| **Error Handling**    | - `[401 Unauthorized]`: Verify the `Authorization` header and token<br>- `[400 Bad Request]`: Check query parameters for typos or missing values<br>- `[500 Internal Server Error]`: Retry after a short delay or check API status |
| **Notes**             | - Maximum page size is 5000 records.<br>- Use the `search-after` token from the response headers for pagination.<br>- Ensure the `Authorization` token is encoded in Base64. |
| **Last Updated**      | 26/11/2024                                                                                            |
| **Author**            | Gabe Chisholm                                                                                         |

# Consumer Data Research Centre (CDRC)
## api_cdrc.R
Replace **USERNAME** and **PASSWORD** with your actual credentials
Please see: https://epc.opendatacommunities.org/docs/api/domestic#domestic-local-authority for further detail on filling in **line 4**
| **Field**             | **Details**                                                                                           |
|-----------------------|------------------------------------------------------------------------------------------------------|
| **API Name**          | CDRC API (IMD Specific)                                                                              |
| **Purpose**           | Provides access to datasets such as IMD 2019 for specified geographies                               |
| **API Type**          | R-based Library                                                                                     |
| **Access Method**     | Via the [`cdrcR`](https://github.com/CDRC/cdrcR) R package                                           |
| **Base URL**          | Not applicable (handled by the `cdrcR` package)                                                     |
| **Supported Methods** | R function calls (`loginCDRC()`, `getCDRC()`)                                                       |
| **Authentication**    | Username and password required for login via `loginCDRC`                                            |
| **Headers Required**  | Not applicable                                                                                      |
| **Request Format**    | Function calls in R: `getCDRC(dataset, geography, geographyCode)`                                   |
| **Query Parameters**  | - `dataset`: Dataset ID (e.g., "IMD2019") <br> - `geography`: Level of geography (e.g., "LADname") <br> - `geographyCode`: Specific areas (e.g., "Hartlepool") |
| **Response Format**   | R data frame                                                                                        |
| **Sample Response**   | `ladCode  LSOA11CD        lsoa11NM imd2010Adjusted nationalQuintile1 nationalDecile2 imdRank`<br> `1 E06000001 E01011959 Hartlepool 014A 11.12 4 7 22790`<br>`2 E06000001 E01011968 Hartlepool 014D 18.24 3 5 15550`<br>`3 E06000001 E01011994 Hartlepool 002F 69.52 1 1 252`<br>`4 E06000001 E01011993 Hartlepool 002E 50.19 1 1 2140`<br>`5 E06000001 E01011992 Hartlepool 002D 51.52 1 1 1925`<br>`6 E06000001 E01011999 Hartlepool 007D 60.34 1 1 795` |
| **Pagination Details**| Not applicable (fetches entire dataset in one call)                                                 |
| **Rate Limits**       | No known limits                                                                                     |
| **Error Handling**    | - Ensure valid credentials are provided. API login is different from standard CDRC login. <br> - Invalid `dataset`, `geography`, or `geographyCode` values may return an empty dataset or nothing at all. |
| **Notes**             | - Data can be further filtered in R using `subset()` or `grepl()`                                   |
| **Last Updated**      | 26/11/2024                                                                                          |
| **Author**            | Gabe Chisholm                                                                                       |

# Local Government Inform (LGInform)
##api_lginform.R
| **Field**             | **Details**                                                                                                                                       |
|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| **API Name**          | LGInform/ESD Web Services API                                                                                                                    |
| **Purpose**           | Provides public health data indicators for specified metrics and areas                                                                           |
| **API Type**          | Web JSON                                                                                                                                         |
| **Access Method**     | Power Query M Script                                                                                                                             |
| **Base URL**          | [https://webservices.esd.org.uk/data.table](https://webservices.esd.org.uk/data.table)                                                           |
| **Supported Methods** | GET                                                                                                                                              |
| **Authentication**    | API Key (passed as a parameter in the query string for security reasons)                                                                         |
| **Headers Required**  | Not applicable                                                                                                                                   |
| **Request Format**    | - Query Parameters: Append `metricType`, `area`, and `period` to the base URL <br> - API key passed using `ApplicationKey`                        |
| **Query Parameters**  | - `valueType`: Specifies the data type (e.g., `raw`) <br> - `metricType`: Comma-separated list of metric identifiers <br> - `area`: Comma-separated list of areas (e.g., local authorities) <br> - `period`: Specifies the time period (e.g., `latest:5`) |
| **Response Format**   | JSON converted to Power BI table                                                                                                                 |
| **Sample Response**   | `{"metricTypeIdentifier": "10749", "metricTypeLabel": "English Baccalaureate - Average Point Score per pupil", "metricTypeAltLabel": "English Baccalaureate - Average Point Score per pupil", "metricTypeIsSummary": false, "areaIdentifier": "E06000001", "areaLabel": "Hartlepool", "areaAltLabel": "Hartlepool", "areaLongLabel": "Hartlepool (Unitary)", "areaIsSummary": false, "periodIdentifier": "sch_2018_19", "periodLabel": "2018/19 (academic)", "periodAltLabel": "2018/19 (academic)", "periodIsSummary": false, "valueTypeIdentifier": "raw", "valueTypeLabel": "Mean", "valueTypeIsSummary": false, "value": 3.51, "source": 3.51, "formatted": "3.51", "format": "#,##0.00", "publicationStatus": "Published"}` |
| **Pagination Details**| Not applicable (all data is fetched in one call)                                                                                                |
| **Rate Limits**       | 10,000mb of data per month                                                                                                                      |
| **Error Handling**    | - Ensure the API key is valid <br> - Check query parameters for typos and unsupported metrics/areas <br> - [500 Internal Server Error]: Retry after a short delay |
| **Notes**             | - The API key (`ApplicationKey`) must be stored securely in Power BI <br> - Results include metadata such as confidence intervals, publication status, and formatting details |
| **Last Updated**      | 26/11/2024                                                                                                                                      |
| **Author**            | Gabe Chisholm                                                                                                                                   |
                                                                                                                              |
                                                                                                                                |
