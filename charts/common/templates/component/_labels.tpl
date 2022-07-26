{{/*
Selector labels
*/}}
{{- define "common.selectorLabels.default" -}}
app.kubernetes.io/name: {{ include "common.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "common.deploy.selectorLabels" -}}
{{- include "common.selectorLabels.default" . }}
{{- $custom := include "common.utils.existsElse" (dict "map" .Values "key" "common.selectorLabels.custom" "default" (dict)) }}
{{- with (fromYaml $custom) }}
{{ toYaml . }}
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
{{- $global := include "common.utils.existsElse" (dict "map" .Values "key" "common.labels.global" "default" (dict)) }}
{{- $deploy := include "common.utils.existsElse" (dict "map" .Values "key" "common.labels.deploy" "default" (dict)) }}
{{- with (merge (fromYaml $global) (fromYaml $deploy)) }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{- define "common.service.labels" -}}
{{ include "common.labels.default" . }}
{{- $global := include "common.utils.existsElse" (dict "map" .Values "key" "common.labels.global" "default" (dict)) }}
{{- $service := include "common.utils.existsElse" (dict "map" .Values "key" "common.labels.service" "default" (dict)) }}
{{- with (merge (fromYaml $global) (fromYaml $service)) }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{- define "common.serviceAccount.labels" -}}
{{ include "common.labels.default" . }}
{{- $global := include "common.utils.existsElse" (dict "map" .Values "key" "common.labels.global" "default" (dict)) }}
{{- $serviceAccount := include "common.utils.existsElse" (dict "map" .Values "key" "common.labels.serviceAccount" "default" (dict)) }}
{{- with (merge (fromYaml $global) (fromYaml $serviceAccount)) }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{- define "common.ingress.labels" -}}
{{ include "common.labels.default" . }}
{{- $global := include "common.utils.existsElse" (dict "map" .Values "key" "common.labels.global" "default" (dict)) }}
{{- $ingress := include "common.utils.existsElse" (dict "map" .Values "key" "common.labels.ingress" "default" (dict)) }}
{{- with (merge (fromYaml $global) (fromYaml $ingress)) }}
{{ toYaml . }}
{{- end }}
{{- end }}