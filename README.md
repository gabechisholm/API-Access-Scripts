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
| **Sample Response**  | ```                                                                                                     |
|                       | lmk.key            address1 address2 address3 postcode building.reference.number                      |
|                       | 1 116bb99005ddf5df9c8c14548950e1939648a43f585943c1c1babea7981bf1a0 90 Owton Manor Lane                   TS25 3AT               10006598897 |
|                       | 2 1468e3dd2a263407b9e29bd4b3e7d00676c960a0759f538f0e5063e11579bb18  31 Sandbanks Drive                   TS24 9RS               10006553608 |
|                       | 3 3908edb7f6caa66fdb6b97b3569a85ab47eb4d29c3f7223e3986b8f773e40231  361 West View Road                   TS24 9LH               10006432247 |
|                       | 4 57449d5864b85973d6ccc0e6f2222e5c546a14216f26bb89385528a0c368fc57        6 Bede Grove                   TS25 5PD               10006579724 |
|                       | 5 5fdc5ddea9f0dcc4fdf402ba0c2e24dd9e0629ba974d844453d7bede5a2d759c  361 West View Road                   TS24 9LH               10006432247 |
|                       | 6 86f85c7a7e08b9832d79840648a9f4bd560ac4e95ae95d0a3efbf8c69fc69dff       113 Northgate                   TS24 0LZ               10006510927 |
|                       | current.energy.rating potential.energy.rating current.energy.efficiency potential.energy.efficiency property.type    built.form inspection.date |
|                       | 1                     D                       C                        55                          69         House   End-Terrace      2024-09-30 |
|                       | 2                     D                       C                        63                          76         House Semi-Detached      2024-09-30 |
|                       | 3                     E                       B                        52                          83         House   Mid-Terrace      2024-07-25 |
|                       | 4                     D                       B                        63                          83         House Semi-Detached      2024-09-30 |
|                       | 5                     E                       B                        52                          83         House   Mid-Terrace      2024-09-30 |
|                       | 6                     D                       B                        64                          81         House   End-Terrace      2024-09-30 |
|                       | ```                                                                                                     |
| **Pagination Details**| - Uses the `X-Next-Search-After` header in the response.<br>- Include `search-after=<token>` in subsequent requests to fetch additional pages. |
| **Rate Limits**       | 5000 rows per request – unlimited* requests                                                            |
| **Error Handling**    | - `[401 Unauthorized]`: Verify the `Authorization` header and token<br>- `[400 Bad Request]`: Check query parameters for typos or missing values<br>- `[500 Internal Server Error]`: Retry after a short delay or check API status |
| **Notes**             | - Maximum page size is 5000 records.<br>- Use the `search-after` token from the response headers for pagination.<br>- Ensure the `Authorization` token is encoded in Base64. |
| **Last Updated**      | 26/11/2024                                                                                            |
| **Author**            | Gabe Chisholm                                                                                         |

## api_cdrc.R
Replace **USERNAME** and **PASSWORD** with your actual credentials

Please see: https://epc.opendatacommunities.org/docs/api/domestic#domestic-local-authority for further detail on filling in **line 4**

