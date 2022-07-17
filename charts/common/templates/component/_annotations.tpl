{{/*
Global annotations
*/}}
{{- define "common.annotations.global" -}}
{{- if not (empty .Values.annotations.global) }}
{{ toYaml .Values.annotations.global }}
{{ end }}
{{- end }}

{{/*
Deploy annotations
*/}}
{{- define "common.annotations.deploy" -}}
{{- if not (empty .Values.annotations.deploy) }}
{{ toYaml .Values.annotations.deploy }}
{{- end }}
{{- end -}}

{{/*
Deploy annotations
*/}}
{{- define "common.deploy.annotations" -}}
{{- include "common.annotations.global" . }}
{{- include "common.annotations.deploy" . }}
{{- end }}