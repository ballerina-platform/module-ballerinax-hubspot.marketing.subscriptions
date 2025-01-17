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

import ballerina/test;

final Client mockClient = check new (
    {
        auth: {
            token: "test-token" // This approach eliminates the need for the client to make additional server requests for token validation, such as a refresh token request in the OAuth2 flow.
        }
    }, "http://localhost:9090"
);

final string mockTestSubscriberUserId = "bh@hubspot.com";
final int:Signed32 mockTestSubscriptionId = 530858989;

@test:Config {
    groups: ["mock_tests"]
}

isolated function mockTestGetCommunicationPreferencesbySubscriberId() returns error? {
    ActionResponseWithResultsPublicStatus response = check hubspot
    ->getCommunicationPreferencesV4StatusesSubscriberidstring
    (testSubscriberUserId, channel = "EMAIL");
    test:assertEquals(response.status, "COMPLETE", "Status should be 'COMPLETE'.");

}

@test:Config {
    groups: ["mock_tests"]
}

isolated function mockTestPostCommunicationPreferencesbySubscriberId() returns error? {
    ActionResponseWithResultsPublicStatus response = check hubspot
    ->postCommunicationPreferencesV4StatusesSubscriberidstring
    (testSubscriberUserId,
        payload = {
        channel: "EMAIL",
        statusState: "SUBSCRIBED",
        subscriptionId: testSubscriptionId

    }
    );

    test:assertEquals(response.status, "COMPLETE", "Status should be 'COMPLETE'.");
}

@test:Config {
    groups: ["mock_tests"]
}

isolated function mockTestGetUnsubscribedStatusbySubscriberId() returns error? {
    ActionResponseWithResultsPublicWideStatus response = check hubspot
    ->getCommunicationPreferencesV4StatusesSubscriberidstringUnsubscribeAll(testSubscriberUserId, channel = "EMAIL");

    test:assertEquals(response.status, "COMPLETE", "Status should be 'COMPLETE'.");
}

@test:Config {
    groups: ["mock_tests"]
}

isolated function mockTestPostBatchUnsubscribeAll() returns error? {
    BatchInputString payload = {
        inputs: [testSubscriberUserId]
    };
    BatchResponsePublicWideStatusBulkResponse response = check hubspot
    ->postCommunicationPreferencesV4StatusesBatchUnsubscribeAllRead
    (payload, channel = "EMAIL");

    test:assertEquals(response.status, "COMPLETE", "Status should be 'COMPLETE'.");
}

@test:Config {
    groups: ["mock_tests"]
}

isolated function mockTestPostCommunicationPreferencesBatchRead() returns error? {
    BatchInputString payload = {
        inputs: [testSubscriberUserId]
    };

    BatchResponsePublicStatusBulkResponse response = check hubspot
    ->postCommunicationPreferencesV4StatusesBatchRead
    (payload, channel = "EMAIL");

    test:assertEquals(response.status, "COMPLETE", "Status should be 'COMPLETE'.");
}

@test:Config {
    groups: ["mock_tests"]
}

isolated function mockTestPostCommunicationPreferencesBatchWrite() returns error? {
    PublicStatusRequest request = {
        statusState: "SUBSCRIBED",
        channel: "EMAIL",
        subscriberIdString: testSubscriberUserId,
        subscriptionId: testSubscriptionId
    };
    BatchInputPublicStatusRequest payload = {
        inputs: [request]
    };

    BatchResponsePublicStatus response = check hubspot
    ->postCommunicationPreferencesV4StatusesBatchWrite(payload);

    test:assertEquals(response.status, "COMPLETE", "Status should be 'COMPLETE'.");
}

@test:Config {
    groups: ["mock_tests"]
}

isolated function mockTestPostUnsubscribeAllbySubscriberId() returns error? {
    ActionResponseWithResultsPublicStatus response = check hubspot
    ->postCommunicationPreferencesV4StatusesSubscriberidstringUnsubscribeAll(testSubscriberUserId, channel = "EMAIL");
    test:assertEquals(response.status, "COMPLETE", "Status should be 'COMPLETE'.");
}

@test:Config {
    groups: ["mock_tests"]
}

isolated function mockTestGetSubscriptionStatusDefinitions() returns error? {
    ActionResponseWithResultsSubscriptionDefinition response = check hubspot
    ->getCommunicationPreferencesV4Definitions();
    test:assertEquals(response.status, "COMPLETE", "Status should be 'COMPLETE'.");
}

