{{- define "slack" -}}
- https://slack.com/api/chat.postMessage
- --header
- Content-Type:application/json
- --header
- Authorization:Bearer {{ .slack.token }}
- --data
- {{ printf "{\"as_user\":\"false\",\"channel\":\"%s\",\"icon_emoji\":\":rocket:\",\"pretty\":\"1\",\"text\":\"%s - `%s` Successfully deployed to *%s*\",\"username\":\"Deployment\"}" .slack.channel .application .revision (.environment | upper ) | quote }}
{{- end -}}
