_Author_:  @SenuDyl\
_Created_: 2025/01/03\
_Updated_: 2025/01/09\
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from HubSpot Marketing Subscriptions. 
The OpenAPI specification is obtained from [Hubspot API Reference](https://github.com/HubSpot/HubSpot-public-api-spec-collection/blob/13f888343a8ec443d95de2c12393015ba3391ac6/PublicApiSpecs/Communication%20Preferences/Subscriptions/Rollouts/176901/v4/subscriptions.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Change the url property of the servers object:

    - **Original**: ` https://api.hubspot.com `
    - **Updated**: ` https://api.hubapi.com/communication-preferences/v4 `
    - **Reason**:This change is made to ensure that all API paths are relative to the URL 
    (/communication-preferences/v4), which improves the consistency and usability of the APIs.

2. Use `--nullable` option when generating the client using the Ballerina OpenAPI tool:

    - **Reason**: The Hubspot API reference does not properly include the "nullable" property for some the request and response schemas. Therefore, the `--nullable` option is used as a precaution to avoid potential data-binding issues in the runtime, which generates all the request/response type fields with the support to handle null values.
    >**Note**: This workaround can be removed once [ballerina-platform/ballerina-library#4870](https://github.com/ballerina-platform/ballerina-library/issues/4870) is addressed.

3. Update API Paths:

    - **Original**: Paths included the version prefix in each endpoint 
   (e.g., /communication-preferences/v4).
    - **Updated**: Paths are modified to remove the version prefix from the endpoints, as it is now included in the base URL. For example:
        - **Original**: ` /communication-preferences/v4/statuses/batch/read `
        - **Updated**: ` /statuses/batch/read `
    - **Reason**: This modification simplifies the API paths, making them shorter and more readable. It also centralizes the versioning to the base URL, which is a common best practice.

4. Remove required fields `errors` and `links` from `StandardError`:

    - **Reason**: Although the HubSpot OpenAPI Specification marks these fields as required, the server returns payload-binding errors during runtime. To resolve this issue, these fields have been removed from the specification.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory. To resolve client ambiguity errors, remote functions were used instead of resource functions..

```bash
bal openapi -i docs/spec/openapi.json --mode client -o ballerina --client-methods remote --license docs/license.txt 
```

