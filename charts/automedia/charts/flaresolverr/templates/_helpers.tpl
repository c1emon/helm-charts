{{/*
Create the name of the service account to use
*/}}
{{- define "flaresolverr.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "common.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
