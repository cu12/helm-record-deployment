# Record Deployment subchart

Goal of the following chart is to record deployments in various services to track the effect of changes better.

## Overview

record-deployment - as of now - supports the following services

- NewRelic ![NewRelic](../assets/newrelic.png)
- Rollbar ![Rollbar](../assets/rollbar.png)
- Slack ![Slack](../assets/slack.png)

## Configuration

In order to use this subchart and to record deployments first you have to define it as a subchart to the project where you wish to use it.

  ```
  dependencies:
  - name: record-deployment
    version: "0.1.0"
    repository: "file://../record-deployment"
  ```

Below you will find the necessary information about what you'll need from specific integrations to make them working.

### NewRelic

To configure integration with NewRelic deployments you will need the `appID` and the `apiKey`

1) Get the `appID` by opening the app in NewRelic and from the address bar copy the relevant part, for eg `https://rpm.newrelic.com/accounts/<account>/applications/*<appID>*`
2) Get the `apiKey` by going to `Account settings` and look for `License key`

It is recommended to inject `apiKey` during the install in a secure way and not save it anywhere in the chart repository.

Parameter | Description | Default
--- | --- | ---
`newrelic.appID` | Application ID in NewRelic APM | `nil`
`newrelic.apiKey` | API key to communication with NewRelic | `nil`
`revision` | Version number or git SHA of the deployment | `nil`

### RollBar

For RollBar you would need a project specific `accessToken` to record deployments.

1) Open project, then click on `Settings` around the top right corner. Go to `Project Access Tokens` and take the `post_server_item` token.

It is recommended to inject `accessToken` during the install in a secure way and not save it anywhere in the chart repository.

Parameter | Description | Default
--- | --- | ---
`rollbar.accessToken` | Application specific Rollbar Token | `nil`
`environment` | Environment of the deployment | `nil`
`revision` | Version number or git SHA of the deployment | `nil`

### Slack

Configuration of Slack also needs a key called `token`.

1) Create a Legacy token at https://api.slack.com/custom-integrations/legacy-tokens

It is recommended to inject `accessToken` during the install in a secure way and not save it anywhere in the chart repository.

Parameter | Description | Default
--- | --- | ---
`slack.token` | Legacy token to communicate with Slack API | `nil`
`slack.channel` | Slack channel to send messages to | `nil`
`application` | Application name | `nil`
`environment` | Environment of the deployment | `nil`
`revision` | Version number or git SHA of the deployment | `nil`


## Usage

If you inject the sensitive parts during your deployment and configure the not sensitive ones, you'll end up with three basic things to pass during deployment.

Example values file as a subchart:

```
record-deployment:
  application: "Super Dashboard"
  environment: "testing"
  revision: "1.0"

  # NewRelic integration enabled
  newrelic:
    appID: !!string 12345678
    apiKey: <api_key>

  # Rollbar integration disabled
  #rollbar:

  # Slack enabled
  slack:
    channel: "#deployments"

```

Specifying revision number could look like the following:

```
helm upgrade --install \
...
--set record-deployment.revision="$TAG"
...
```
