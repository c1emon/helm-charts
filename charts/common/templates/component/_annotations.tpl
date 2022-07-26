{{/*
Deploy annotations
*/}}
{{- define "common.deploy.annotations" -}}
{{- $global := include "common.utils.existsElse" (dict "map" .Values "key" "common.annotations.global" "default" (dict)) }}
{{- $deploy := include "common.utils.existsElse" (dict "map" .Values "key" "common.annotations.deploy" "default" (dict)) }}
{{- with (merge (fromYaml $global) (fromYaml $deploy)) }}
{{- toYaml . }}
{{- end }}
{{- end }}

{{- define "common.serviceAccount.annotations" -}}
{{- $global := include "common.utils.existsElse" (dict "map" .Values "key" "common.annotations.global" "default" (dict)) }}
{{- $serviceAccount := include "common.utils.existsElse" (dict "map" .Values "key" "common.annotations.serviceAccount" "default" (dict)) }}
{{- with (merge (fromYaml $global) (fromYaml $serviceAccount)) }}
{{- toYaml . }}
{{- end }}
{{- end }}

{{- define "common.ingress.annotations" -}}
{{- $global := include "common.utils.existsElse" (dict "map" .Values "key" "common.annotations.global" "default" (dict)) }}
{{- $ingress := include "common.utils.existsElse" (dict "map" .Values "key" "common.annotations.ingress" "default" (dict)) }}
{{- with (merge (fromYaml $global) (fromYaml $ingress)) }}
{{- toYaml . }}
{{- end }}
{{- end }}