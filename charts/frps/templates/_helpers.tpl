{{/*
Expand the name of the chart.
*/}}
{{- define "frps.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Frps config bind
*/}}
{{- define "frps.config.bind.tcp.pod" -}}
{{- default 7000 .Values.frps.bind.tcp.pod -}}
{{- end }}

{{- define "frps.config.bind.tcp.ing" -}}
{{- default 7000 .Values.frps.bind.tcp.ing -}}
{{- end }}

{{- define "frps.config.bind.udp.pod" -}}
{{- default 7000 .Values.frps.bind.udp.pod -}}
{{- end }}

{{- define "frps.config.bind.udp.ing" -}}
{{- default 7000 .Values.frps.bind.udp.ing -}}
{{- end }}

{{- define "frps.config.dashboard.port" -}}
{{- default 7500 .Values.frps.dashboard.port -}}
{{- end }}

{{- define "frps.config.dashboard.host" -}}
{{- default "dashboard.frp.example.com" .Values.frps.dashboard.host | quote -}}
{{- end }}

{{- define "frps.config.name" -}}
{{- $defaultConfig := printf "%s-ini" .Chart.Name -}}
{{- .Values.frps.config.name | default $defaultConfig | quote -}}
{{- end }}

{{- define "frps.config.path" -}}
{{- default "/etc/frp" .Values.frps.config.path -}}
{{- end }}

{{- define "frps.config.deploy.ports" -}}
{{- range .Values.frps.ports }}
- name: {{ .name }}
  containerPort: {{ .local }}
  protocol: {{ default "TCP" .protocol }}
{{- end }}
{{- end }}

{{- define "frps.config.svc.ports" -}}
{{- range .Values.frps.ports }}
- port: {{ .remote }}
  targetPort: {{ .name }}
  protocol: {{ default "TCP" .protocol }}
  name: {{ .name }}
{{- end }}
{{- end }}

{{- define "frps.config.http.endpoint.port" }}
{{- default 7080 .Values.frps.httpEndpoint.podPort -}}
{{- end }}

{{- define "frps.config.ingress.hosts" }}
{{- range .Values.frps.httpEndpoint.hosts }}
- host: {{ .host | quote }}
  http:
    paths:
    - path: /
      pathType: Prefix
      backend:
        service:
          name: {{ include "frps.fullname" $ }}
          port:
            number: 80
{{- end }}
{{- end }}

{{- define "frps.config.ingress.tls" }}
{{- range .Values.frps.httpEndpoint.hosts }}
{{- if .tls }}
- hosts:
    - {{ .host | quote }}
  secretName: {{ .host | replace "." "-" | printf "%s-tls-cert" | quote }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "frps.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
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
{{- define "frps.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "frps.labels" -}}
helm.sh/chart: {{ include "frps.chart" . }}
{{ include "frps.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "frps.selectorLabels" -}}
app.kubernetes.io/name: {{ include "frps.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "frps.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "frps.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
