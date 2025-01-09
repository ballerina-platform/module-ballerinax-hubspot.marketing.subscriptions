// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
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

import ballerina/http;

service on new http:Listener(9090) {
    # Retrieve all subscription status definitions
    # + return - successful operation 
    resource isolated function get definitions() returns ActionResponseWithResultsSubscriptionDefinition {
        return {
            status: "COMPLETE",
            results: [
                {
                    "businessUnitId": 0,
                    "id": "530858991",
                    "name": "Marketing Information",
                    "description": "Marketing offers and updates.",
                    "purpose": "Marketing",
                    "communicationMethod": "Email",
                    "isActive": true,
                    "isDefault": true,
                    "isInternal": false,
                    "createdAt": "2024-12-16T07:05:32.319Z",
                    "updatedAt": "2024-12-16T07:05:32.319Z"
                },
                {
                    "businessUnitId": 0,
                    "id": "530858989",
                    "name": "Customer Service Communication",
                    "description": "Receive feedback requests and customer service information.",
                    "purpose": "Service",
                    "communicationMethod": "Email",
                    "isActive": true,
                    "isDefault": true,
                    "isInternal": true,
                    "createdAt": "2024-12-16T07:05:31.669Z",
                    "updatedAt": "2024-12-16T07:05:31.669Z"
                },
                {
                    "businessUnitId": 0,
                    "id": "530858990",
                    "name": "One to One",
                    "description": "One to One emails",
                    "purpose": "Sales",
                    "communicationMethod": "Email",
                    "isActive": true,
                    "isDefault": true,
                    "isInternal": true,
                    "createdAt": "2024-12-16T07:05:32.223Z",
                    "updatedAt": "2024-12-16T07:05:32.223Z"
                }
            ],
            startedAt: "2025-01-07T09:55:16.916Z",
            completedAt: "2025-01-07T09:55:17.401Z"
        };
    };

    # Get subscription preferences for a specific contact
    #
    # + subscriberIdString - The contact's email address.
    # + return - successful operation 
    resource isolated function get statuses/[string subscriberIdString]() returns ActionResponseWithResultsPublicStatus {
        return {
            status: "COMPLETE",
            results: [
                {
                    "businessUnitId": 0,
                    "channel": "EMAIL",
                    "subscriberIdString": "bh@hubspot.com",
                    "subscriptionId": 530858989,
                    "subscriptionName": "Customer Service Communication",
                    "status": "UNSUBSCRIBED",
                    "source": "Public status API, App ID:5848098",
                    "legalBasis": null,
                    "legalBasisExplanation": null,
                    "setStatusSuccessReason": null,
                    "timestamp": "2025-01-08T04:18:48.015Z"
                },
                {
                    "businessUnitId": 0,
                    "channel": "EMAIL",
                    "subscriberIdString": "bh@hubspot.com",
                    "subscriptionId": 530858990,
                    "subscriptionName": "One to One",
                    "status": "UNSUBSCRIBED",
                    "source": "Public status API, App ID:5848098",
                    "legalBasis": null,
                    "legalBasisExplanation": null,
                    "setStatusSuccessReason": null,
                    "timestamp": "2025-01-08T04:18:48.015Z"
                },
                {
                    "businessUnitId": 0,
                    "channel": "EMAIL",
                    "subscriberIdString": "bh@hubspot.com",
                    "subscriptionId": 530858991,
                    "subscriptionName": "Marketing Information",
                    "status": "UNSUBSCRIBED",
                    "source": "Public status API, App ID:5848098",
                    "legalBasis": null,
                    "legalBasisExplanation": null,
                    "setStatusSuccessReason": null,
                    "timestamp": "2025-01-08T04:18:48.015Z"
                }
            ],
            startedAt: "2025-01-08T05:33:44.626Z",
            completedAt: "2025-01-08T05:33:45.416Z"
        };
    };

    resource isolated function get statuses/[string subscriberIdString]/unsubscribe\-all() returns ActionResponseWithResultsPublicWideStatus {
        return {
            status: "COMPLETE",
            results: [
                {
                    "wideStatusType": "PORTAL_WIDE",
                    "subscriberIdString": "bh@hubspot.com",
                    "status": "UNSUBSCRIBED",
                    "channel": "EMAIL",
                    "timestamp": "2025-01-08T04:18:48.015Z"
                }
            ],
            startedAt: "2025-01-08T05:45:01.690Z",
            completedAt: "2025-01-08T05:45:02.568Z"
        };
    };

    # Update a contact's subscription status
    #
    # + subscriberIdString - The contact's email address. 
    # + return - successful operation 
    resource isolated function post statuses/[string subscriberIdString](@http:Payload PartialPublicStatusRequest payload) returns ActionResponseWithResultsPublicStatus {
        return {
            status: "COMPLETE",
            results: [
                {
                    "businessUnitId": 0,
                    "channel": "EMAIL",
                    "subscriberIdString": "bh@hubspot.com",
                    "subscriptionId": 530858989,
                    "subscriptionName": "Customer Service Communication",
                    "status": "SUBSCRIBED",
                    "source": "Public status API, App ID:5848098",
                    "legalBasis": "LEGITIMATE_INTEREST_PQL",
                    "legalBasisExplanation": "string",
                    "setStatusSuccessReason": "RESUBSCRIBE_OCCURRED",
                    "timestamp": "2025-01-08T05:51:16.245Z"
                }
            ],
            startedAt: "2025-01-08T05:51:16.162Z",
            completedAt: "2025-01-08T05:51:16.438Z"
        };
    };

    resource isolated function post statuses/[string subscriberIdString]/unsubscribe\-all() returns ActionResponseWithResultsPublicStatus {
        return {
            status: "COMPLETE",
            results: [],
            startedAt: "2025-01-08T06:01:18.001Z",
            completedAt: "2025-01-08T06:01:18.237Z"
        };
    };

    # Batch retrieve subscription statuses
    #
    # + return - successful operation 
    resource isolated function post statuses/batch/read(@http:Payload BatchInputString payload) returns BatchResponsePublicStatusBulkResponse {
        return {
            status: "COMPLETE",
            results: [
                {
                    "subscriberIdString": "bh@hubspot.com",
                    "statuses": [
                        {
                            "businessUnitId": 0,
                            "channel": "EMAIL",
                            "subscriberIdString": "bh@hubspot.com",
                            "subscriptionId": 530858989,
                            "subscriptionName": "Customer Service Communication",
                            "status": "UNSUBSCRIBED",
                            "source": "Public status API, App ID:5848098",
                            "legalBasis": null,
                            "legalBasisExplanation": null,
                            "setStatusSuccessReason": null,
                            "timestamp": "2025-01-08T06:01:18.033Z"
                        },
                        {
                            "businessUnitId": 0,
                            "channel": "EMAIL",
                            "subscriberIdString": "bh@hubspot.com",
                            "subscriptionId": 530858990,
                            "subscriptionName": "One to One",
                            "status": "UNSUBSCRIBED",
                            "source": "Public status API, App ID:5848098",
                            "legalBasis": null,
                            "legalBasisExplanation": null,
                            "setStatusSuccessReason": null,
                            "timestamp": "2025-01-08T06:01:18.033Z"
                        },
                        {
                            "businessUnitId": 0,
                            "channel": "EMAIL",
                            "subscriberIdString": "bh@hubspot.com",
                            "subscriptionId": 530858991,
                            "subscriptionName": "Marketing Information",
                            "status": "UNSUBSCRIBED",
                            "source": "Public status API, App ID:5848098",
                            "legalBasis": null,
                            "legalBasisExplanation": null,
                            "setStatusSuccessReason": null,
                            "timestamp": "2025-01-08T06:01:18.033Z"
                        }
                    ]
                }
            ],
            startedAt: "2025-01-08T06:15:22.294Z",
            completedAt: "2025-01-08T06:15:22.352Z"
        };
    };

    # Batch retrieve contacts who have opted out of all communications
    #
    # + return - successful operation 
    resource isolated function post statuses/batch/unsubscribe\-all/read(@http:Payload BatchInputString payload) returns BatchResponsePublicWideStatusBulkResponse {
        return {
            status: "COMPLETE",
            results: [
                {
                    "subscriberIdString": "bh@hubspot.com",
                    "wideStatuses": [
                        {
                            "wideStatusType": "PORTAL_WIDE",
                            "subscriberIdString": "bh@hubspot.com",
                            "status": "UNSUBSCRIBED",
                            "channel": "EMAIL",
                            "timestamp": "2025-01-08T06:01:18.033Z"
                        }
                    ]
                }
            ],
            startedAt: "2025-01-08T06:21:20.425Z",
            completedAt: "2025-01-08T06:21:20.545Z"

        };
    };

    # Batch update subscription status
    #
    # + return - successful operation 
    resource isolated function post statuses/batch/write(@http:Payload BatchInputPublicStatusRequest payload) returns BatchResponsePublicStatus {
        return {
            status: "COMPLETE",
            results: [
                {
                    "businessUnitId": 0,
                    "channel": "EMAIL",
                    "subscriberIdString": "bh@hubspot.com",
                    "subscriptionId": 530858989,
                    "subscriptionName": "Customer Service Communication",
                    "status": "SUBSCRIBED",
                    "source": "Public status API, App ID:5848098",
                    "legalBasis": "LEGITIMATE_INTEREST_PQL",
                    "legalBasisExplanation": "string",
                    "setStatusSuccessReason": "RESUBSCRIBE_OCCURRED",
                    "timestamp": "2025-01-08T06:34:39.478Z"
                }
            ],
            startedAt: "2025-01-08T06:34:39.389Z",
            completedAt: "2025-01-08T06:34:39.598Z"
        };
    };
};

