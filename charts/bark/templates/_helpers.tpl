{{/*
Create the name of the service account to use
*/}}
{{- define "bark.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "bark.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
