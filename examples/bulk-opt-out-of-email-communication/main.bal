import ballerina/io;
import ballerinax/hubspot.marketing.subscriptions as hsmsubscriptions;
import ballerina/oauth2;

// Configuration for the hsmsubscriptions client
configurable string clientId = ?;          
configurable string clientSecret = ?;      
configurable string refreshToken = ?;     
configurable string serviceUrl = ?;       

// Configure the connection settings for HubSpot API using OAuth2
final hsmsubscriptions:ConnectionConfig hsmsubscriptionsConfig = {
    auth : {
        clientId,
        clientSecret,
        refreshToken,
        credentialBearer: oauth2:POST_BODY_BEARER 
    }
};

// Create a client object to interact with the HubSpot Marketing Subscriptions API
final hsmsubscriptions:Client hsmsubscriptions = check new (hsmsubscriptionsConfig, "https://api.hubapi.com/communication-preferences/v4");

// An array of subscriber user IDs to be processed
final string[] subscriberUserIdArray = ["bh@hubspot.com"];  // Example subscriber email (can be expanded)

public function main() returns error? {

    hsmsubscriptions:BatchInputString payload = {
            inputs:subscriberUserIdArray
        };
    
    hsmsubscriptions:BatchResponsePublicStatusBulkResponse subscriptionStatusResponse = check hsmsubscriptions-> /statuses/batch/read.post(payload,channel="EMAIL");
    
    foreach hsmsubscriptions:PublicStatusBulkResponse subscriberDetails in subscriptionStatusResponse.results{
        boolean alreadyOptedOut = true;
        foreach hsmsubscriptions:PublicStatus subscriptions in subscriberDetails.statuses {
            if subscriptions.status=="UNSUBSCRIBED"{
                continue;
            }else{                
                hsmsubscriptions:ActionResponseWithResultsPublicStatus response = check hsmsubscriptions-> /statuses/[subscriberDetails.subscriberIdString]/unsubscribe\-all.post(channel="EMAIL");
                io:println(response);
                alreadyOptedOut=false;
                io:println("User is successfully opted-out from all email subscriptions.");
                break;
            }
        }
        if (alreadyOptedOut){
            io:println("User is already opted-out of all email subscriptions.");
        }
    }    
}
