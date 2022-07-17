{{/*
Selector labels
*/}}
{{- define "common.selectorLabels.default" -}}
{{- if .Values.selectorLabels.default }}
app.kubernetes.io/name: {{ include "common.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- end }}

{{- define "common.selectorLabels.custom" -}}
{{- if not (empty .Values.selectorLabels.custom) }}
{{ toYaml .Values.selectorLabels.custom }}
{{- end }}
{{- end }}

{{- define "common.deploy.selectorLabels" -}}
{{- if and (not (empty .Values.selectorLabels.custom)) (.Values.selectorLabels.default) -}}
{{- fail "ether selectorLabels.default or selectorLabels.custom must be set" }}
{{- end }}
{{- include "common.selectorLabels.default" . }}
{{- include "common.selectorLabels.custom" . }}
{{- end }}

{{/*
Default labels
*/}}
{{- define "common.labels.default" -}}
{{- if .Values.labels.default }}
helm.sh/chart: {{ include "common.chart" . -}}
{{ include "common.deploy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
{{- end }}

{{/*
Global labels
*/}}
{{- define "common.labels.global" -}}
{{- if .Values.labels.global }}
{{ toYaml .Values.labels.global }}
{{- end }}
{{- end }}

{{- define "common.labels.deploy" -}}
{{- if not (empty .Values.labels.deploy) }}
{{ toYaml .Values.labels.deploy }}
{{- end }}
{{- end }}

{{/*
Deploy labels
*/}}
{{- define "common.deploy.labels" -}}
{{- include "test.labels.default" . }}
{{- include "test.labels.global" . }}
{{- include "test.labels.deploy" . }}
{{- end }}