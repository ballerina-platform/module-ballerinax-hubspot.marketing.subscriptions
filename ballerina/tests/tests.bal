//import ballerina/os;
import ballerina/test;
import ballerina/oauth2;
import ballerina/io;

// configurable boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
// configurable string userId = isLiveServer ? os:getEnv("HUBSPOT_USER_ID") : "test";
// configurable string token = isLiveServer ? os:getEnv("HUBSPOT_TOKEN") : "test";
// configurable string serviceUrl = isLiveServer ? "HUBSPOT_URL" : "http://localhost:9090";

OAuth2RefreshTokenGrantConfig auth = {
       clientId: "eb325c08-f081-4a86-ac38-d6c948512650",
       clientSecret: "f955d4fe-1236-4463-a213-4ff67aa34e43",
       refreshToken: "na1-fe49-1133-47f4-8c0d-99d3492e16c9",
       credentialBearer: oauth2:POST_BODY_BEARER // this line should be added in to when you are going to create auth object.
   };

configurable string serviceUrl = "https://api.hubapi.com";

ConnectionConfig config = {auth: auth};
final Client hubspot = check new Client(config, serviceUrl);

final string testUserId = "48566579";

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
//Check this one
isolated function testGetCommunicationPreferencesbySubscriberId() returns error? {
    ActionResponseWithResultsPublicStatus response = check hubspot-> /communication\-preferences/v4/statuses/["senurim@wso2.com"](channel="EMAIL");
    test:assertTrue(response?.status is "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE");
    //test:assertTrue(response?.errors is ());
    io:println(response);

}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testPostCommunicationPreferencesbySubscriberId() returns error? {
    ActionResponseWithResultsPublicStatus response = check hubspot-> /communication\-preferences/v4/statuses/["senurim@wso2.com"].post(
        payload={
            channel:"EMAIL",
            statusState: "SUBSCRIBED",
            subscriptionId:1

        }
    );
    test:assertTrue(response?.status is "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE");
    //test:assertTrue(response?.errors is ());
    io:println(response);

}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testGetUnsubscribedStatusbySubscriberId() returns error? {
    ActionResponseWithResultsPublicWideStatus response = check hubspot-> /communication\-preferences/v4/statuses/["senurim@wso2.com"]/unsubscribe\-all(channel="EMAIL");
    test:assertTrue(response?.status is "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE");
    //test:assertTrue(response?.errors is ());
    io:println(response);

}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testPostReadBatchUnsubscribeAll() returns error? {
     BatchInputString payload = {
            inputs:["senurim@wso2.com"]
        };
    BatchResponsePublicWideStatusBulkResponse response = check hubspot-> /communication\-preferences/v4/statuses/batch/unsubscribe\-all/read.post(payload,channel="EMAIL");
    test:assertTrue(response?.status is "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE");
    //test:assertTrue(response?.errors is ());
    io:println(response);

}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
//Check this one too. It has the same payload binding error for null values. Again resolved by sanitization
isolated function testPostCommunicationPreferencesBatchRead() returns error? {
    BatchInputString payload = {
            inputs:["senurim@wso2.com"]
        };
    
    BatchResponsePublicStatusBulkResponse response = check hubspot-> /communication\-preferences/v4/statuses/batch/read.post(payload,channel="EMAIL");
    test:assertTrue(response?.status is "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE");
    //test:assertTrue(response?.errors is ());
    io:println(response);
}
//This one has the ambiguous error - Resolved after sanitization to the api path by adding /read at the end
@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testPostBatchUnsubscribeAll() returns error? {
    BatchInputString payload = {
            inputs:["senurim@wso2.com"]
        };
    
    BatchResponsePublicWideStatusBulkResponse response = check hubspot-> /communication\-preferences/v4/statuses/batch/unsubscribe\-all/read.post(payload,channel="EMAIL");
    test:assertTrue(response?.status is "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE");
    //test:assertTrue(response?.errors is ());
    io:println(response);

}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testPostCommunicationPreferencesBatchWWrite() returns error? {
    PublicStatusRequest request1 ={
         statusState: "SUBSCRIBED",
         channel: "EMAIL",
         subscriberIdString: "senurim@wso2.com",
         subscriptionId: 0
    };
    BatchInputPublicStatusRequest payload = {
            inputs:[request1]
        };
    
    BatchResponsePublicStatus response = check hubspot-> /communication\-preferences/v4/statuses/batch/write.post(payload);
    test:assertTrue(response?.status is "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE");
    //test:assertTrue(response?.errors is ());
    io:println(response);

}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testPostUnsubscribeAllbySubscriberId() returns error? {
    ActionResponseWithResultsPublicStatus response = check hubspot-> /communication\-preferences/v4/statuses/["senurim@wso2.com"]/unsubscribe\-all.post(channel="EMAIL");
    test:assertTrue(response?.status is "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE");
    //test:assertTrue(response?.errors is ());
    io:println(response);

}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testGetSubscriptionStatusDefinitions() returns error? {
    ActionResponseWithResultsSubscriptionDefinition response = check hubspot-> /communication\-preferences/v4/definitions;
    test:assertTrue(response?.status is "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE");
    //test:assertTrue(response?.errors is ());
    io:println(response);

}





