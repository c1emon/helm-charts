{{/*
Selector labels
add global custom annotations to .Values.common.selectorLabels.custom
usage: {{- include "common.selectorLabels.default" . | nindent 4 }}
*/}}
{{- define "common.selectorLabels.default" -}}
app.kubernetes.io/name: {{ include "common.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
usage: {{- include "common.deploy.selectorLabels" . | nindent 4 }}
*/}}
{{- define "common.deploy.selectorLabels" -}}
{{- include "common.selectorLabels.default" . }}
{{- $custom := include "common.utils.existsElse" (dict "map" .Values "key" "common.selectorLabels.custom" "default" (dict)) }}
{{- with (fromYaml $custom) }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Labels
add global custom labels to .Values.common.labels.global
usage: {{- include "common.labels.default" . | nindent 4 }}
*/}}
{{- define "common.labels.default" -}}
helm.sh/chart: {{ include "common.chart" . }}
{{ include "common.deploy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Deploy labels
add deploy custom labels to .Values.common.labels.deploy
usage: {{- include "common.deploy.labels" . | nindent 4 }}
*/}}
{{- define "common.deploy.labels" -}}
{{ include "common.labels.default" . }}
{{- $global := include "common.utils.existsElse" (dict "map" .Values "key" "common.labels.global" "default" (dict)) }}
{{- $deploy := include "common.utils.existsElse" (dict "map" .Values "key" "common.labels.deploy" "default" (dict)) }}
{{- with (merge (fromYaml $global) (fromYaml $deploy)) }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Service labels
add service custom labels to .Values.common.labels.service
usage: {{- include "common.service.labels" . | nindent 4 }}
*/}}
{{- define "common.service.labels" -}}
{{ include "common.labels.default" . }}
{{- $global := include "common.utils.existsElse" (dict "map" .Values "key" "common.labels.global" "default" (dict)) }}
{{- $service := include "common.utils.existsElse" (dict "map" .Values "key" "common.labels.service" "default" (dict)) }}
{{- with (merge (fromYaml $global) (fromYaml $service)) }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
ServiceAccount labels
add serviceAccount custom labels to .Values.common.labels.serviceAccount
usage: {{- include "common.serviceAccount.labels" . | nindent 4 }}
*/}}
{{- define "common.serviceAccount.labels" -}}
{{ include "common.labels.default" . }}
{{- $global := include "common.utils.existsElse" (dict "map" .Values "key" "common.labels.global" "default" (dict)) }}
{{- $serviceAccount := include "common.utils.existsElse" (dict "map" .Values "key" "common.labels.serviceAccount" "default" (dict)) }}
{{- with (merge (fromYaml $global) (fromYaml $serviceAccount)) }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Ingress labels
add ingress custom labels to .Values.common.labels.ingress
usage: {{- include "common.ingress.labels" . | nindent 4 }}
*/}}
{{- define "common.ingress.labels" -}}
{{ include "common.labels.default" . }}
{{- $global := include "common.utils.existsElse" (dict "map" .Values "key" "common.labels.global" "default" (dict)) }}
{{- $ingress := include "common.utils.existsElse" (dict "map" .Values "key" "common.labels.ingress" "default" (dict)) }}
{{- with (merge (fromYaml $global) (fromYaml $ingress)) }}
{{ toYaml . }}
{{- end }}
{{- end }}