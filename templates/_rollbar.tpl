{{- define "rollbar" -}}
- https://api.rollbar.com/api/1/deploy/
- --data
- {{ printf "{\"access_token\": \"%s\", \"environment\": \"%s\", \"revision\": \"%s\"}" .rollbar.accessToken .environment .revision | quote }}
{{- end -}}
