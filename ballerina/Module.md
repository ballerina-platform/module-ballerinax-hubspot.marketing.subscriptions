## Overview

[HubSpot](https://www.hubspot.com) is an AI-powered customer relationship management (CRM) platform. 

The `ballerinax/hubspot.marketing.subscriptions` offers APIs to connect and interact with the [HubSpot API for Marketing Subscriptions](https://developers.hubspot.com/docs/reference/api/marketing/subscriptions) endpoints, specifically based on the [HubSpot Marketing Events REST API](https://developers.hubspot.com/docs/reference/api).

Use the subscriptions API to programmatically subscribe or unsubscribe contacts from your email subscription types, or unsubscribe a contact from all email communication. These APIs also provide support for business units.


## Setup guide

To use the HubSpot Marketing Subscriptions Connector, you must have access to the HubSpot API via a HubSpot Developer Account and a HubSpot App associated with it. If you don't already have one, you need to register for a developer account at HubSpot.

### Step 1: Create/Login to a HubSpot Developer Account

If you already have an account, go to the [HubSpot developer portal](https://app.hubspot.com/).

If you don't have a HubSpot Developer Account, you can sign up to a free account [here](https://developers.hubspot.com/get-started).

### Step 2 (Optional): Create a [Developer Test Account](https://developers.hubspot.com/beta-docs/getting-started/account-types#developer-test-accounts) under your account

Within app developer accounts, you can create developer test accounts to test apps and integrations without affecting any real HubSpot data.

>**Note:** These accounts are intended solely for development and testing purposes and should not be used in production environments.

1. Navigate to "Test Account" section from the left sidebar.

   ![Hubspot developer portal](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.marketing.subscriptions/main/docs/setup/resources/Test1.png)   
   
2. Click "Create developer test account".

   ![Hubspot developer portal](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.marketing.subscriptions/main/docs/setup/resources/Test2.png)

3. In the dialog box, provide a name to your test account and click "Create".

   ![Hubspot developer portal](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.marketing.subscriptions/main/docs/setup/resources/Test3.png)

### Step 3: Create a HubSpot App under your account.

1. In your developer account, navigate to the "Apps" section. Click "Create App".

   ![Hubspot developer portal](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.marketing.subscriptions/main/docs/setup/resources/Test4.png)

2. Provide the necessary details, including the app name and description.

### Step 4: Configure the Authentication Flow.

1. Move to the "Auth" Tab.

   ![Hubspot developer portal](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.marketing.subscriptions/main/docs/setup/resources/Test5.png)

2. In the Scopes section, add the following scopes for your app by using the "Add new scope" button.

   * `communication_preferences.read_write`
   * `communication_preferences.statuses.batch.read`
   * `communication_preferences.statuses.batch.write`

   ![Hubspot developer portal](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.marketing.subscriptions/main/docs/setup/resources/Test6.png)

4. Add your Redirect URI in the appropriate section. You can also use _localhost_ addresses for local development purposes. Click "Create App".

   ![Hubspot developer portal](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.marketing.subscriptions/main/docs/setup/resources/Test7.png)

### Step 5: Get your Client ID and Client Secret

- Navigate to the "Auth" section of your app. Make sure to save the provided Client ID and Client Secret.

   ![Hubspot developer portal](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.marketing.subscriptions/main/docs/setup/resources/Test8.png)

### Step 6: Setup Authentication Flow

Before proceeding with the Quickstart, make sure you have obtained the Access Token using the following steps:

1. Create an authorization URL using the following format:

   ```read
   https://app.hubspot.com/oauth/authorize?client_id=<YOUR_CLIENT_ID>&scope=<YOUR_SCOPES>&redirect_uri=<YOUR_REDIRECT_URI>
   ```

   Replace the `<YOUR_CLIENT_ID>`, `<YOUR_REDIRECT_URI>` and `<YOUR_CLIENT_SECRET>` with your specific value.

    >**NOTE:** If you are using a localhost redirect url, make sure to have a listener running at the relevant port before executing the next step.

2. Paste it in the browser and select your developer test account to authorize the app when prompted.

   ![Hubspot developer portal](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.marketing.subscriptions/main/docs/setup/resources/Test9.png)

3. An authorization code appears in the browser. Copy the code.

4. Run the following curl command. Replace the `<YOUR_CLIENT_ID>`, `<YOUR_REDIRECT_URI>` and `<YOUR_CLIENT_SECRET>` with your specific value. Use the code you received in the step 3 above as the `<CODE>`.

   - Linux/macOS

     ```bash
     curl --request POST \
     --url https://api.hubapi.com/oauth/v1/token \
     --header 'content-type: application/x-www-form-urlencoded' \
     --data 'grant_type=authorization_code&code=<CODE>&redirect_uri=<YOUR_REDIRECT_URI>&client_id=<YOUR_CLIENT_ID>&client_secret=<YOUR_CLIENT_SECRET>'
     ```

   - Windows

     ```bash
     curl --request POST ^
     --url https://api.hubapi.com/oauth/v1/token ^
     --header 'content-type: application/x-www-form-urlencoded' ^
     --data 'grant_type=authorization_code&code=<CODE>&redirect_uri=<YOUR_REDIRECT_URI>&client_id=<YOUR_CLIENT_ID>&client_secret=<YOUR_CLIENT_SECRET>'
     ```

   This command returns a JSON response containing access_token and refresh_token.

   ```json
   {
     "token_type": "bearer",
     "refresh_token": "<Refresh Token>",
     "access_token": "<Access Token>",
     "expires_in": 1800
   }
   ```

5. Store the access token securely for use in your application.

## Quickstart

To use the `HubSpot Marketing Subscriptions` connector in your Ballerina application, update the `.bal` file as shown below:

### Step 1: Import the module

Import the `hubspot.marketing.subscriptions` module and `oauth2` module.

```ballerina
import ballerina/oauth2;
import ballerinax/hubspot.marketing.subscriptions as hsmsubscriptions;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and, configure the obtained credentials in the above steps as follows:

   ```toml
    clientId = <Client Id>
    clientSecret = <Client Secret>
    refreshToken = <Refresh Token>
   ```

2. Instantiate a `hsmsubscriptions:ConnectionConfig` with the obtained credentials and initialize the connector with it.

    ```ballerina 
    configurable string clientId = ?;
    configurable string clientSecret = ?;
    configurable string refreshToken = ?;

    final hsmsubscriptions:ConnectionConfig hsmsubscriptionsConfig = {
        auth : {
            clientId,
            clientSecret,
            refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        }
    };

    final hsmsubscriptions:Client hsmsubscriptions = check new (hsmsubscriptionsConfig);
    ```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations. A sample use case is shown below.

#### Get subscription preferences for a specific contact

```
public function main() returns error? {
    hsmsubscriptions: ActionResponseWithResultsPublicWideStatus response = getCommunicationPreferencesV4StatusesSubscriberidstring(subscriberUserId,channel = "EMAIL");
}  

```
### Step 4: Run the Ballerina application

```
bal run
```


## Examples

The `HubSpot Marketing Subscriptions` connector provides practical examples that illustrate its usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-hubspot.marketing.subscriptions/tree/main/examples/), which cover the following use cases:

1. [Event-Based Email Preference Update](https://github.com/ballerina-platform/module-ballerinax-hubspot.marketing.subscriptions/tree/main/examples/event-based-email-preference-update) - Check and update email preferences for event attendees, ensuring that those who unsubscribed post-event are bulk resubscribed for future engagement.

2. [Bulk Opt-Out of All Email Communication](https://github.com/ballerina-platform/module-ballerinax-hubspot.marketing.subscriptions/tree/main/examples/bulk-opt-out-of-email-communication) - Process a batch of opt-out requests to efficiently unsubscribe multiple customers from all email communications in bulk.
