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

// Subscription ID to filter responses for a specific subscription
final int:Signed32 subscriptionId = 530858989;

public function main() returns error? {
    // Array to store user IDs who need to be resubscribed
    string[] subscriberIdString = [];
        
    // Loop through each subscriber user ID in the array
    foreach string subscriberUserId in subscriberUserIdArray {
        // Make a request to HubSpot API to check subscription status for each user
        hsmsubscriptions:ActionResponseWithResultsPublicStatus response = check hsmsubscriptions-> /statuses/[subscriberUserId](channel="EMAIL");
            
        foreach hsmsubscriptions:PublicStatus item in response.results {
            // Check if the subscription ID matches the one we are interested in
            if (item.subscriptionId == subscriptionId) {
                // If the user is unsubscribed, add them to the list of IDs to resubscribe
                if (item.status == "UNSUBSCRIBED") {
                    subscriberIdString.push(subscriberUserId);
                }
            }
        }
    }
    if (subscriberIdString.length()==0){
        io:println("Users are already subscribed to this service!");
    }else{
        // Prepare the request to resubscribe users by changing their subscription status to "SUBSCRIBED"
        hsmsubscriptions:PublicStatusRequest[] inputs =[];

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
        hsmsubscriptions:BatchResponsePublicStatus response = check hsmsubscriptions-> /statuses/batch/write.post(payload);
        io:println("Users are successfully subscribed to this service!");
        
    }
}
