{{/*
Another version of templete function dig
usage: {{ include "common.utils.existsElse" (dict "map" someMap "key" "some.of.key" "default" "key") }}
P.S "default" can also be some object like .Values.labels
Because helm templete didn't support custom function 
and define just creates a templete which just return !string!. 
So the return value is transformed to yaml formatt, 
which can be recover by fromYaml function.
example:
{{ $val := fromYaml (include "common.utils.existsElse" (dict ...)) }}
{{ $val.key0 }}
*/}}
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