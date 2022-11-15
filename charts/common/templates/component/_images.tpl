{{/*
Get image

params:
  # optional
  registry: ""
  repository: nginx
  # dig has higher priority than tag
  # optional
  dig: ""
  # Overrides the image tag whose default is latest.
  # optional
  tag: ""

Usage: {{ include "common.image" (dict "registry" "" "repository" "" "dig" "" "tag" "") | quote }}
*/}}
{{- define "common.image" -}}
{{- if not .repository }}
{{- fail "must provide repository" }}
{{- end }}
{{- $image := "" }}
{{- if .registry }}
{{- $image = (printf "%s/%s" .registry .repository) }}
{{- else }}
{{- $image = (printf "%s" .repository) }}
{{- end }}
{{- if .dig }}
{{- printf "%s@%s" $image .dig }}
{{- else -}}
{{- printf "%s:%s" $image (.tag | default "latest") }}
{{- end }}
{{- end }}
