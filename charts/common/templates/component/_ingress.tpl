{{/*
Ingress class name helper
auto add ngress.class annotations from .Values.ingress.className
*/}}
{{- define "common.ingress.helper.className" -}}
{{- $className := (include "common.utils.existsElse" (dict "map" .Values "key" "ingress.className" "default" "<error>")) -}}
{{- if and (ne $className "<error>") (not (semverCompare ">=1.18-0" .Capabilities.KubeVersion.GitVersion)) }}
  {{- if not (hasKey .Values.common.annotations.ingress "kubernetes.io/ingress.class") }}
  {{- $_ := set .Values.common.annotations.ingress "kubernetes.io/ingress.class" $className}}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Ingress class name
auto add ingressClassName from .Values.ingress.className
example of ingress:
---
apiVersion: {{ include "common.ingress.apiVer" . }}
kind: Ingress
metadata:
  name: {{ include "common.fullname" . }}
  annotations:
    {{- include "common.ingress.annotations" . | nindent 4 }}
spec:
  {{- include "common.ingress.className" . | indent 2 }}
  rules:
    ......
---
*/}}
{{- define "common.ingress.className" -}}
{{- $className := (include "common.utils.existsElse" (dict "map" .Values "key" "ingress.className" "default" "<error>")) -}}
{{- if and (ne $className "<error>") (semverCompare ">=1.18-0" .Capabilities.KubeVersion.GitVersion) }}
ingressClassName: {{ $className }}
{{- end }}
{{- end }}
