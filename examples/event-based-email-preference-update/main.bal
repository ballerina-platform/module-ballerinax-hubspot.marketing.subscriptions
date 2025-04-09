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

// Configuration for the hsmsubscriptions client
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

// Subscription ID to filter responses for a specific subscription
final int:Signed32 subscriptionId = 530858989; // Example subscription ID

public function main() returns error? {
    // Array to store user IDs who need to be resubscribed
    string[] subscriberIdString = [];

    // Loop through each subscriber user ID in the array
    foreach string subscriberUserId in subscriberUserIdArray {
        // Make a request to HubSpot API to check subscription status for each user
        hsmsubscriptions:ActionResponseWithResultsPublicStatus response = check hsmSubscriptions->getCommunicationPreferencesV4StatusesSubscriberIdString(subscriberUserId, channel = "EMAIL");

        foreach hsmsubscriptions:PublicStatus item in response.results {
            // Check if the subscription ID matches the one we are interested in, If the user is unsubscribed, add them to the list of IDs to resubscribe
            if item.subscriptionId == subscriptionId && item.status == "UNSUBSCRIBED" {
                subscriberIdString.push(subscriberUserId);

            }
        }
    }
    if subscriberIdString.length() == 0 {
        io:println("Users are already subscribed to this service!");
    } else {
        // Prepare the request to resubscribe users by changing their subscription status to "SUBSCRIBED"
        hsmsubscriptions:PublicStatusRequest[] inputs = [];

        foreach string subscriberId in subscriberIdString {
            hsmsubscriptions:PublicStatusRequest request = {
                statusState: "SUBSCRIBED",
                channel: "EMAIL",
                subscriberIdString: subscriberId,
                subscriptionId: subscriptionId
            };
            inputs.push(request);
        }

        // Create a payload for batch processing of subscription updates
        hsmsubscriptions:BatchInputPublicStatusRequest payload = {
            inputs: inputs
        };

        // Send the batch request to HubSpot API to update the subscription statuses
        hsmsubscriptions:BatchResponsePublicStatus _ = check hsmSubscriptions->postCommunicationPreferencesV4StatusesBatchWrite(payload);
        io:println("Users are successfully subscribed to this service!");
    }
}
