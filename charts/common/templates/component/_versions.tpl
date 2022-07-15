{{/*
Kube version
*/}}
{{- define "common.kubeVer" -}}
{{- if .Values.global -}}
    {{- if .Values.global.kubeVersion -}}
        {{- .Values.global.kubeVersion -}}
    {{- else -}}
        {{- default .Capabilities.KubeVersion.Version .Values.kubeVersion -}}
    {{- end -}}
{{- else -}}
    {{- default .Capabilities.KubeVersion.Version .Values.kubeVersion -}}
{{- end -}}
{{- end -}}

{{/*
Deploy api version
*/}}
{{- define "common.deploy.apiVer" -}}
{{- if semverCompare "<1.14-0" (include "common.kubeVer" .) -}}
    {{- print "extensions/v1beta1" -}}
{{- else -}}
    {{- print "apps/v1" -}}
{{- end -}}
{{- end -}}