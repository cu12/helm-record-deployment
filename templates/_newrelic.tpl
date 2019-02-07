{{- define "newrelic" -}}
- https://api.newrelic.com/v2/applications/{{ .newrelic.appId }}/deployments.json
- -X POST
- --header
- X-Api-Key:{{ .newrelic.apiKey }}
- --header
- Content-Type:application/json
- --data
- {{ printf "{\"deployment\": {\"revision\": \"%s\"}}" .revision | squote }}
{{- end -}}
