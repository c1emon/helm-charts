{{/*
Selector labels
*/}}
{{- define "common.selectorLabels.default" -}}
app.kubernetes.io/name: {{ include "common.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "common.deploy.selectorLabels" -}}
{{ include "common.selectorLabels.default" . }}
{{- if not (empty .Values.selectorLabels.custom) }}
{{ toYaml .Values.selectorLabels.custom }}
{{- end }}
{{- end }}

{{/*
Labels
*/}}
{{- define "common.labels.default" -}}
helm.sh/chart: {{ include "common.chart" . }}
{{ include "common.deploy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "common.deploy.labels" -}}
{{ include "common.labels.default" . }}
{{- with (merge .Values.labels.global .Values.labels.deploy) }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{- define "common.service.labels" -}}
{{ include "common.labels.default" . }}
{{- with (merge .Values.labels.global .Values.labels.service) }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{- define "common.ingress.labels" -}}
{{ include "common.labels.default" . }}
{{- with (merge .Values.labels.global .Values.labels.ingress) }}
{{ toYaml . }}
{{- end }}
{{- end }}