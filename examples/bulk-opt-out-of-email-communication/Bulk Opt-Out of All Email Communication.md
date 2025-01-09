# Bulk Opt-Out of All Email Communication

This use case demonstrates how the HubSpot Marketing Subscription API can be used to efficiently unsubscribe customers in bulk who have submitted opt-out requests for all email communication. This approach helps save time, ensures all requests are processed quickly, and improves overall customer experience by honoring their preferences.

# Prerequisites

## 1. Setup HubSpot developer account

Refer to the [Setup Guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.marketing.subscriptions/blob/main/README.md) to obtain necessary credentials.

## 2. Configuration

Create a Config.toml file in the example's root directory and, provide your HubSpot account related configurations as follows:

    ```toml
    clientId= "<clientId>"
    clientSecret= "<clientSecret>"
    refreshToken= "<refreshToken>"
    ```

# Run the example

Execute the following command to run the example:

    ```bash
    bal run
    ```
