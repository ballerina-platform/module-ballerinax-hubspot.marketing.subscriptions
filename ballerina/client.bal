// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is auto-generated by the Ballerina OpenAPI tool.

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

import ballerina/data.jsondata;
import ballerina/http;

public isolated client class Client {
    final http:Client clientEp;
    final readonly & ApiKeysConfig? apiKeyConfig;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://api.hubapi.com/communication-preferences/v4") returns error? {
        http:ClientConfiguration httpClientConfig = {httpVersion: config.httpVersion, http1Settings: config.http1Settings, http2Settings: config.http2Settings, timeout: config.timeout, forwarded: config.forwarded, followRedirects: config.followRedirects, poolConfig: config.poolConfig, cache: config.cache, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, cookieConfig: config.cookieConfig, responseLimits: config.responseLimits, secureSocket: config.secureSocket, proxy: config.proxy, socketConfig: config.socketConfig, validation: config.validation, laxDataBinding: config.laxDataBinding};
        if config.auth is ApiKeysConfig {
            self.apiKeyConfig = (<ApiKeysConfig>config.auth).cloneReadOnly();
        } else {
            httpClientConfig.auth = <http:BearerTokenConfig|OAuth2RefreshTokenGrantConfig>config.auth;
            self.apiKeyConfig = ();
        }
        self.clientEp = check new (serviceUrl, httpClientConfig);
    }

    # Batch update subscription status
    #
    # + headers - Headers to be sent with the request 
    # + return - successful operation 
    resource isolated function post statuses/batch/write(BatchInputPublicStatusRequest payload, map<string|string[]> headers = {}) returns BatchResponsePublicStatus|error {
        string resourcePath = string `/statuses/batch/write`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.privateApp;
        }
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    resource isolated function get statuses/[string subscriberIdString]/unsubscribe\-all(map<string|string[]> headers = {}, *GetCommunicationPreferencesV4StatusesSubscriberIdStringUnsubscribeAllQueries queries) returns ActionResponseWithResultsPublicWideStatus|error {
        string resourcePath = string `/statuses/${getEncodedUri(subscriberIdString)}/unsubscribe-all`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app-legacy"] = self.apiKeyConfig?.privateAppLegacy;
        }
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    resource isolated function post statuses/[string subscriberIdString]/unsubscribe\-all(map<string|string[]> headers = {}, *PostCommunicationPreferencesV4StatusesSubscriberIdStringUnsubscribeAllQueries queries) returns ActionResponseWithResultsPublicStatus|error {
        string resourcePath = string `/statuses/${getEncodedUri(subscriberIdString)}/unsubscribe-all`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app-legacy"] = self.apiKeyConfig?.privateAppLegacy;
        }
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Batch retrieve subscription statuses
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - successful operation 
    resource isolated function post statuses/batch/read(BatchInputString payload, map<string|string[]> headers = {}, *PostCommunicationPreferencesV4StatusesBatchReadQueries queries) returns BatchResponsePublicStatusBulkResponse|BatchResponsePublicStatusBulkResponseWithErrors|error {
        string resourcePath = string `/statuses/batch/read`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.privateApp;
        }
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    resource isolated function post statuses/batch/unsubscribe\-all(BatchInputString payload, map<string|string[]> headers = {}, *PostCommunicationPreferencesV4StatusesBatchUnsubscribeAllQueries queries) returns BatchResponsePublicBulkOptOutFromAllResponse|error {
        string resourcePath = string `/statuses/batch/unsubscribe-all`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.privateApp;
        }
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Retrieve all subscription status definitions
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - successful operation 
    resource isolated function get definitions(map<string|string[]> headers = {}, *GetCommunicationPreferencesV4DefinitionsQueries queries) returns ActionResponseWithResultsSubscriptionDefinition|error {
        string resourcePath = string `/definitions`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app-legacy"] = self.apiKeyConfig?.privateAppLegacy;
        }
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Batch retrieve contacts who have opted out of all communications
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - successful operation 
    resource isolated function post statuses/batch/unsubscribe\-all/read(BatchInputString payload, map<string|string[]> headers = {}, *PostCommunicationPreferencesV4StatusesBatchUnsubscribeAllReadQueries queries) returns BatchResponsePublicWideStatusBulkResponse|BatchResponsePublicWideStatusBulkResponseWithErrors|error {
        string resourcePath = string `/statuses/batch/unsubscribe-all/read`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app"] = self.apiKeyConfig?.privateApp;
        }
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Get subscription preferences for a specific contact
    #
    # + subscriberIdString - The contact's email address
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - successful operation 
    resource isolated function get statuses/[string subscriberIdString](map<string|string[]> headers = {}, *GetCommunicationPreferencesV4StatusesSubscriberIdStringQueries queries) returns ActionResponseWithResultsPublicStatus|error {
        string resourcePath = string `/statuses/${getEncodedUri(subscriberIdString)}`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app-legacy"] = self.apiKeyConfig?.privateAppLegacy;
        }
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Update a contact's subscription status
    #
    # + subscriberIdString - The contact's email address
    # + headers - Headers to be sent with the request 
    # + return - successful operation 
    resource isolated function post statuses/[string subscriberIdString](PartialPublicStatusRequest payload, map<string|string[]> headers = {}) returns ActionResponseWithResultsPublicStatus|error {
        string resourcePath = string `/statuses/${getEncodedUri(subscriberIdString)}`;
        map<anydata> headerValues = {...headers};
        if self.apiKeyConfig is ApiKeysConfig {
            headerValues["private-app-legacy"] = self.apiKeyConfig?.privateAppLegacy;
        }
        map<string|string[]> httpHeaders = http:getHeaderMap(headerValues);
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }
}
