{{/*
Global labels
*/}}
{{- define "common.annotations.global" -}}
{{- if .Values.annotations.global }}
{{ toYaml .Values.annotations.global }}
{{- end }}
{{- end }}

{{/*
Deploy labels
*/}}
{{- define "common.deploy.annotations" -}}
{{- include "common.annotations.global" . }}
{{- if .Values.annotations.deploy }}
{{ toYaml .Values.annotations.deploy }}
{{- end }}
{{- end }}