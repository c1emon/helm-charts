{{/*
Selector labels
*/}}
{{- define "common.selectorLabels" -}}
app.kubernetes.io/name: {{ include "common.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Default labels
*/}}
{{- define "common.labels.default" -}}
{{- if .Values.labels.default }}
helm.sh/chart: {{ include "common.chart" . }}
{{ include "common.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
{{- end }}

{{/*
Global labels
*/}}
{{- define "common.labels.global" -}}
{{- if .Values.labels.global }}
{{ toYaml .Values.labels.global }}
{{- end }}
{{- end }}

{{/*
Deploy labels
*/}}
{{- define "common.deploy.labels" -}}
{{- include "common.labels.default" . }}
{{- include "common.labels.global" . }}
{{- if .Values.labels.deploy }}
{{ toYaml .Values.labels.deploy }}
{{- end }}
{{- end }}