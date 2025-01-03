_Author_:  Senuri Mallikarachchi\
_Created_: 2025/01/03\
_Updated_: <!-- TODO: Add date --> \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from HubSpot Marketing Subscriptions. 
The OpenAPI specification is obtained from [Hubspot API Reference](https://github.com/HubSpot/HubSpot-public-api-spec-collection/blob/13f888343a8ec443d95de2c12393015ba3391ac6/PublicApiSpecs/Communication%20Preferences/Subscriptions/Rollouts/176901/v4/subscriptions.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

[//]: # (TODO: Add sanitation details)
1. Change the url property of the servers object:

    - Original: https://api.hubspot.com
    - Updated: https://api.hubapi.com/communication-preferences/v4
    - Reason: This change is made to ensure that all API paths are relative to the versioned base URL (/v4), which improves the consistency and usability of the APIs.

2. Use `--nullable` option when generating the client using the Ballerina OpenAPI tool:

    - The Hubspot API reference does not properly include the "nullable" property for some the request and response schemas.
    - Therefore, the `--nullable` option is used as a precaution to avoid potential data-binding issues in the runtime, which will generate all the request/response type fields with the support to handle null values.
    - This workaround can be removed once [ballerina-platform/ballerina-library#4870](https://github.com/ballerina-platform/ballerina-library/issues/4870) is addressed.

3. Update API Paths:
    - Original: Paths included the version prefix in each endpoint (e.g., /2/compliance/jobs).
    - Updated: Paths are modified to remove the version prefix from the endpoints, as it is now included in the base URL. For example:
        - Original: /communication-preferences/v4/statuses/batch/read
        - Updated: //statuses/batch/read
    - Reason: This modification simplifies the API paths, making them shorter and more readable. It also centralizes the versioning to the base URL, which is a common best practice.

    - Original: /communication-preferences/v4/statuses/batch/unsubscribe-all
    - Updated: /statuses/batch/unsubscribe-all/read
    - Reason: This modification resolves the error that occurs when Ballerina cannot determine which resource method to invoke due to ambiguity in the resource method definition. It is overcome by changing the original API path to a clearly ditinguishable path.

4. Remove certain required field

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
# TODO: Add OpenAPI CLI command used to generate the client
```
Note: The license year is hardcoded to 2024, change if necessary.
