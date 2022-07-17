{{- define "common.deploy.full" -}}
apiVersion: {{ include "common.deploy.apiVer" . }}
kind: Deployment
metadata:
  name: {{ include "common.fullname" . }}
  labels:
    {{- include "common.deploy.labels" . | indent 4 }}
spec:
  {{- if not .Values.autoscaling.enabled }}
  replicas: {{ .Values.replicaCount }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "common.deploy.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      {{- if or (not (empty .Values.annotations.global)) (not (empty .Values.annotations.deploy)) }}
      annotations:
        {{- include "common.deploy.annotations" . | trim | nindent 8 }}
      {{- end }}
      labels:
        {{- include "common.deploy.selectorLabels" . | nindent 8 }}
    spec:
      {{- if not (empty .Values.image.PullSecrets) }}
      imagePullSecrets:
        {{- toYaml .Values.image.PullSecrets | nindent 8 }}
      {{- end }}
      serviceAccountName: {{ include "common.serviceAccountName" . }}
      securityContext:
        {{- toYaml .Values.podSecurityContext | nindent 8 }}
      containers:
        - name: {{ .Chart.Name }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: {{ include "common.image" . }}
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - name: http
              containerPort: 80
              protocol: TCP
          livenessProbe:
            httpGet:
              path: /
              port: http
          readinessProbe:
            httpGet:
              path: /
              port: http
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
      {{- with .Values.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.affinity }}
      affinity:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.tolerations }}
      tolerations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
{{- end -}}
