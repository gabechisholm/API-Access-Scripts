## api_epc.R
# Energy Performance Certificates
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
                                                                                              |
| **Pagination Details**| - Uses the `X-Next-Search-After` header in the response.<br>- Include `search-after=<token>` in subsequent requests to fetch additional pages. |
| **Rate Limits**       | 5000 rows per request – unlimited* requests                                                            |
| **Error Handling**    | - `[401 Unauthorized]`: Verify the `Authorization` header and token<br>- `[400 Bad Request]`: Check query parameters for typos or missing values<br>- `[500 Internal Server Error]`: Retry after a short delay or check API status |
| **Notes**             | - Maximum page size is 5000 records.<br>- Use the `search-after` token from the response headers for pagination.<br>- Ensure the `Authorization` token is encoded in Base64. |
| **Last Updated**      | 26/11/2024                                                                                            |
| **Author**            | Gabe Chisholm                                                                                         |
                                                                                      |

## api_cdrc.R
Replace **USERNAME** and **PASSWORD** with your actual credentials

Please see: https://epc.opendatacommunities.org/docs/api/domestic#domestic-local-authority for further detail on filling in **line 4**

