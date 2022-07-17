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

{{/*
Ingress api version
*/}}
{{- define "common.ingress.apiVer" -}}
{{- if semverCompare ">=1.19-0" .Capabilities.KubeVersion.GitVersion -}}
    {{- print "networking.k8s.io/v1" -}}
{{- else if semverCompare ">=1.14-0" .Capabilities.KubeVersion.GitVersion -}}
    {{- print "networking.k8s.io/v1beta1" -}}
{{- else -}}
    {{- print "extensions/v1beta1" -}}
{{- end }}
{{- end -}}
