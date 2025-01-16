# Examples

The `HubSpot Marketing Subscriptions` connector provides practical examples that illustrate its usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-hubspot.marketing.subscriptions/tree/main/examples/), which cover the following use cases:

1. [Event-Based Email Preference Update](https://github.com/ballerina-platform/module-ballerinax-hubspot.marketing.subscriptions/tree/main/examples/event-based-email-preference-update) - Check and update email preferences for event attendees, ensuring post-event unsubscribed attendees are bulk resubscribed for future engagement.

2. [Bulk Opt-Out of All Email Communication](https://github.com/ballerina-platform/module-ballerinax-hubspot.marketing.subscriptions/tree/main/examples/bulk-opt-out-of-email-communication) - Process a batch of opt-out requests to efficiently unsubscribe multiple customers from all email communications in bulk.

## Prerequisites

1. Generate HubSpot credentials to authenticate the connector as described in the [Setup Guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.marketing.subscriptions/blob/main/README.md).

2. For each example, create a `Config.toml` file the related configuration. Here's an example of how your `Config.toml` file should look:

    ```toml
    clientId= "<clientId>"
    clientSecret= "<clientSecret>"
    refreshToken= "<refreshToken>"
    ```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
