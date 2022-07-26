{{- define "common.utils.existsElse" -}}
  {{- $mapToCheck := index . "map" -}}
  {{- $keyToFind := index . "key" -}}
  {{- $default := index . "default" -}}
  {{- $keySet := (splitList "." $keyToFind) -}}
  {{- $firstKey := first $keySet -}}
  {{- if index $mapToCheck $firstKey -}} {{/* The key was found */}}
    {{- if eq 1 (len $keySet) -}}{{/* The final key in the set implies we're done */}}
      {{- (default $default (index $mapToCheck $firstKey)) | toYaml | indent 0 -}}
    {{- else }}{{/* More keys to check, recurse */}}
      {{- include "common.utils.existsElse" (dict "map" (index $mapToCheck $firstKey) "key" (join "." (rest $keySet)) "default" $default) }}
    {{- end }}
  {{- else }}{{/* The key was not found */}}
      {{- $default | toYaml | indent 0 -}}
  {{- end }}
{{- end }}