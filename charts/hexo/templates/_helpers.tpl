{{/*
Create the name of the service account to use
*/}}
{{- define "hexo.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "common.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "image" -}}
{{- if .Values.image.dig }}
{{- printf "%s@%s" .Values.image.repository .Values.image.dig }}
{{- else -}}
{{- printf "%s:%s" .Values.image.repository (.Values.image.tag | default "latest") }}
{{- end }}
{{- end }}
