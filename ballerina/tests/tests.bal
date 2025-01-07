import ballerina/test;
import ballerina/oauth2;

configurable boolean isLiveServer = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string serviceUrl = ?;

OAuth2RefreshTokenGrantConfig auth = {
       clientId: clientId,
       clientSecret: clientSecret,
       refreshToken: refreshToken,
       credentialBearer: oauth2:POST_BODY_BEARER // this line should be added to create auth object.
   };

ConnectionConfig config = {auth: auth};
final Client hubspot = check new Client(config, serviceUrl);

final string testSubscriberUserId = "bh@hubspot.com";

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testGetCommunicationPreferencesbySubscriberId() returns error? {
    ActionResponseWithResultsPublicStatus response = check hubspot-> /statuses/[testSubscriberUserId](channel="EMAIL");
    test:assertTrue(response?.results.length() !is 0);   
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testPostCommunicationPreferencesbySubscriberId() returns error? {
    ActionResponseWithResultsPublicStatus response = check hubspot-> /statuses/[testSubscriberUserId].post(
        payload={
            channel:"EMAIL",
            statusState: "SUBSCRIBED",
            subscriptionId:530858989

        }
    );
    test:assertTrue(response?.results.length() !is 0);  
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testGetUnsubscribedStatusbySubscriberId() returns error? {
    ActionResponseWithResultsPublicWideStatus response = check hubspot-> /statuses/[testSubscriberUserId]/unsubscribe\-all(channel="EMAIL");
    test:assertTrue(response?.results.length() !is 0);  
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testPostBatchUnsubscribeAll() returns error? {
     BatchInputString payload = {
            inputs:[testSubscriberUserId]
        };
    BatchResponsePublicWideStatusBulkResponse response = check hubspot-> /statuses/batch/unsubscribe\-all/read.post(payload,channel="EMAIL");
    test:assertTrue(response?.results.length() !is 0);  
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testPostCommunicationPreferencesBatchRead() returns error? {
    BatchInputString payload = {
            inputs:[testSubscriberUserId]
        };
    
    BatchResponsePublicStatusBulkResponse response = check hubspot-> /statuses/batch/read.post(payload,channel="EMAIL");
    test:assertTrue(response?.results.length() !is 0);  
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testPostCommunicationPreferencesBatchWrite() returns error? {
    PublicStatusRequest request1 ={
         statusState: "SUBSCRIBED",
         channel: "EMAIL",
         subscriberIdString: testSubscriberUserId,
         subscriptionId: 530858989
    };
    BatchInputPublicStatusRequest payload = {
            inputs:[request1]
        };
    
    BatchResponsePublicStatus response = check hubspot-> /statuses/batch/write.post(payload);
    test:assertTrue(response?.results.length() !is 0);  
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testPostUnsubscribeAllbySubscriberId() returns error? {
    ActionResponseWithResultsPublicStatus response = check hubspot-> /statuses/[testSubscriberUserId]/unsubscribe\-all.post(channel="EMAIL");
    test:assertTrue(response?.results.length() is 0);  
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function testGetSubscriptionStatusDefinitions() returns error? {
    ActionResponseWithResultsSubscriptionDefinition response = check hubspot-> /definitions;
    test:assertTrue(response?.results.length() !is 0);  
}







