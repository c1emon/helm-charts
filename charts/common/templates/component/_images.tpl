{{/*
image
*/}}
{{- define "common.image" -}}
{{- if or (empty .Values.image.repository) (empty .Values.image.tag) }}
{{- fail "ether repository or tag shouldn't be empty" }}
{{- end }}
"{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
{{- end }}