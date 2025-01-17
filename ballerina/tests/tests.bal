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

import ballerina/oauth2;
import ballerina/test;

final boolean isLiveServer = false; // When running against the live server set this variable to true
configurable string clientId = "clientId";
configurable string clientSecret = "clientSecret";
configurable string refreshToken = "refreshToken";
final string serviceUrl = isLiveServer ? "https://api.hubapi.com/communication-preferences/v4" : "http://localhost:9090";

OAuth2RefreshTokenGrantConfig auth = {
    clientId,
    clientSecret,
    refreshToken,
    credentialBearer: oauth2:POST_BODY_BEARER // this line should be added to create auth object.
};

final Client hubspot = check new Client({auth}, serviceUrl);

final string testSubscriberUserId = "bh@hubspot.com";
final int:Signed32 testSubscriptionId = 530858989;

@test:Config {
    enable: isLiveServer,
    groups: ["live_tests"]
}

isolated function testGetCommunicationPreferencesbySubscriberId() returns error? {
    ActionResponseWithResultsPublicStatus response = check hubspot
    ->getCommunicationPreferencesV4StatusesSubscriberidstring
    (testSubscriberUserId, channel = "EMAIL");
    test:assertEquals(response.status, "COMPLETE", "Status should be 'COMPLETE'.");
}

@test:Config {
    enable: isLiveServer,
    groups: ["live_tests"]
}

isolated function testPostCommunicationPreferencesbySubscriberId() returns error? {
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
    enable: isLiveServer,
    groups: ["live_tests"]
}

isolated function testGetUnsubscribedStatusbySubscriberId() returns error? {
    ActionResponseWithResultsPublicWideStatus response = check hubspot
    ->getCommunicationPreferencesV4StatusesSubscriberidstringUnsubscribeAll(testSubscriberUserId, channel = "EMAIL");
    test:assertEquals(response.status, "COMPLETE", "Status should be 'COMPLETE'.");
}

@test:Config {
    enable: isLiveServer,
    groups: ["live_tests"]
}

isolated function testPostBatchUnsubscribeAll() returns error? {
    BatchInputString payload = {
        inputs: [testSubscriberUserId]
    };
    BatchResponsePublicWideStatusBulkResponse response = check hubspot
    ->postCommunicationPreferencesV4StatusesBatchUnsubscribeAllRead
    (payload, channel = "EMAIL");
    test:assertEquals(response.status, "COMPLETE", "Status should be 'COMPLETE'.");
}

@test:Config {
    enable: isLiveServer,
    groups: ["live_tests"]
}

isolated function testPostCommunicationPreferencesBatchRead() returns error? {
    BatchInputString payload = {
        inputs: [testSubscriberUserId]
    };

    BatchResponsePublicStatusBulkResponse response = check hubspot
    ->postCommunicationPreferencesV4StatusesBatchRead
    (payload, channel = "EMAIL");
    test:assertEquals(response.status, "COMPLETE", "Status should be 'COMPLETE'.");
}

@test:Config {
    enable: isLiveServer,
    groups: ["live_tests"]
}

isolated function testPostCommunicationPreferencesBatchWrite() returns error? {
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
    enable: isLiveServer,
    groups: ["live_tests"]
}

isolated function testPostUnsubscribeAllbySubscriberId() returns error? {
    ActionResponseWithResultsPublicStatus response = check hubspot
    ->postCommunicationPreferencesV4StatusesSubscriberidstringUnsubscribeAll(testSubscriberUserId, channel = "EMAIL");
    test:assertEquals(response.status, "COMPLETE", "Status should be 'COMPLETE'.");
}

@test:Config {
    enable: isLiveServer,
    groups: ["live_tests"]
}

isolated function testGetSubscriptionStatusDefinitions() returns error? {
    ActionResponseWithResultsSubscriptionDefinition response = check hubspot
    ->getCommunicationPreferencesV4Definitions();
    test:assertEquals(response.status, "COMPLETE", "Status should be 'COMPLETE'.");
}

@test:Config {
    enable: isLiveServer,
    groups: ["live_tests"]
}

isolated function testPostBatchUnsubscribeAllRead() returns error? {
    BatchInputString payload = {
        inputs: [testSubscriberUserId]
    };
    BatchResponsePublicWideStatusBulkResponse response = check hubspot
    ->postCommunicationPreferencesV4StatusesBatchUnsubscribeAllRead
    (payload, channel = "EMAIL");
    test:assertEquals(response.status, "COMPLETE", "Status should be 'COMPLETE'.");
}

