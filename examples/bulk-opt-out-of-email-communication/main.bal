// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerina/oauth2;
import ballerinax/hubspot.marketing.subscriptions as hsmsubscriptions;

// Configuration for the hsmSubscriptions client
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

// Configure the connection settings for HubSpot API using OAuth2
final hsmsubscriptions:ConnectionConfig hsmSubscriptionsConfig = {
    auth: {
        clientId,
        clientSecret,
        refreshToken,
        credentialBearer: oauth2:POST_BODY_BEARER
    }
};

// Create a client object to interact with the HubSpot Marketing Subscriptions API
final hsmsubscriptions:Client hsmSubscriptions = check new (hsmSubscriptionsConfig);

// An array of subscriber user IDs to be processed
final string[] subscriberUserIdArray = ["bh@hubspot.com"]; // Example subscriber email (can be expanded)

public function main() returns error? {
    // Prepare the payload with the list of subscriber IDs (user email addresses in this case)
    hsmsubscriptions:BatchInputString payload = {
        inputs: subscriberUserIdArray
    };

    // Call the HubSpot API to get the subscription status for the users
    hsmsubscriptions:BatchResponsePublicStatusBulkResponse subscriptionStatusResponse = check hsmSubscriptions->
    postCommunicationPreferencesV4StatusesBatchRead(payload, channel = "EMAIL");

    foreach hsmsubscriptions:PublicStatusBulkResponse subscriberDetails in subscriptionStatusResponse.results {
        boolean alreadyOptedOut = true;
        // Check each subscription status for the current subscriber
        foreach hsmsubscriptions:PublicStatus subscriptions in subscriberDetails.statuses {
            if subscriptions.status == "UNSUBSCRIBED" {
                continue;
            } else {
                // If the user is not unsubscribed, perform an action to unsubscribe from all emails     
                hsmsubscriptions:ActionResponseWithResultsPublicWideStatus _ = check hsmSubscriptions->
                getCommunicationPreferencesV4StatusesSubscriberidstringUnsubscribeAll(subscriberDetails.subscriberIdString, channel = "EMAIL");
                alreadyOptedOut = false;
                io:println(subscriberDetails.subscriberIdString, ": User is successfully opted-out from all email subscriptions.");
                break;
            }
        }
        if alreadyOptedOut {
            io:println(subscriberDetails.subscriberIdString, ": User is already opted-out of all email subscriptions.");
        }
    }
}
