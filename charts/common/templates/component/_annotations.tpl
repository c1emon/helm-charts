{{/*
Deploy annotations
*/}}
{{- define "common.deploy.annotations" -}}
{{- with (merge .Values.annotations.global .Values.annotations.deploy) }}
{{- toYaml . }}
{{- end }}
{{- end }}

{{- define "common.serviceAccount.annotations" -}}
{{- with (merge .Values.annotations.global .Values.annotations.serviceAccount) }}
{{- toYaml . }}
{{- end }}
{{- end }}

{{- define "common.ingress.annotations" -}}
{{- with (merge .Values.annotations.global .Values.annotations.ingress) }}
{{- toYaml . }}
{{- end }}
{{- end }}