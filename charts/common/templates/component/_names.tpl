{{/*
Expand the name of the chart.
*/}}
{{- define "common.name" -}}
{{- if and .Values (ne (dig "common" "name" "<miss>" (.Values | merge (dict))) "<miss>") .Values.common.name }}
{{- .Values.common.name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "common.fullname" -}}
{{- if and .Values (ne (dig "common" "fullname" "<miss>" (.Values | merge (dict))) "<miss>") .Values.common.fullname }}
{{- .Values.common.fullname | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name (include "common.name" .) }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
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