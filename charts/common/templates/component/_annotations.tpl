{{/*
Deploy annotations
*/}}
{{- define "common.deploy.annotations" -}}
{{- with (merge .Values.annotations.global .Values.annotations.deploy) }}
{{- toYaml . }}
{{- end }}
{{- end }}