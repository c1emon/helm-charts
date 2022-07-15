{{/*
Selector labels
*/}}
{{- define "common.deploy.selectorLabels" -}}
{{- if .Values.selectorLabels.default -}}
app.kubernetes.io/name: {{ include "common.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Values.selectorLabels.custom }}
{{ toYaml .Values.selectorLabels.custom }}
{{- end }}
{{- else }}
{{- if empty .Values.selectorLabels.custom }}
{{- fail "ether selectorLabels.default or selectorLabels.custom must be set" }}
{{- end }}
{{- if .Values.selectorLabels.custom }}
{{- toYaml .Values.selectorLabels.custom }}
{{- end }}
{{- end }}
{{- end }}


{{/*
Default labels
*/}}
{{- define "common.labels.default" -}}
{{- if .Values.labels.default }}
helm.sh/chart: {{ include "common.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "common.deploy.selectorLabels" . }}
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