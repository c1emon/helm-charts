{{/*
Expand the name of the chart.
*/}}
{{- define "common.name" -}}
{{- $name := include "common.utils.existsElse" (dict "map" .Values "key" "common.name" "default" .Chart.Name) }}
{{- $name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "common.fullname" -}}
{{- $name := default .Chart.Name (include "common.name" .) }}
{{- $default := "" }}
{{- if contains $name .Release.Name }}
{{- $default = .Release.Name }}
{{- else }}
{{- $default = (printf "%s-%s" .Release.Name $name) }}
{{- end }}
{{- $fullname := include "common.utils.existsElse" (dict "map" .Values "key" "common.fullname" "default" $default) }}
{{- $fullname | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "common.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Get the name of namespace
*/}}
{{- define "common.namespace" -}}
{{- printf "%s" .Release.Namespace | trimSuffix "-" }}
{{- end -}}