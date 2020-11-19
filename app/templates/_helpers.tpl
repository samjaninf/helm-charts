{{/* -------- Name -------- */}}
{{- define "app.name" -}}
{{- default .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* -------- Full Name -------- */}}
{{- define "app.fullName" -}}
{{- printf "%s-%s-%s" .Values.type .Values.pool .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* -------- Chart Name -------- */}}
{{- define "app.chartName" -}}
{{- default .Values.type .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* -------- Domain -------- */}}
{{- define "app.domain" -}}
{{- printf "%s.%s" .Release.Name .Values.ingress.rootDomain }}
{{- end }}

{{/* -------- Common Labels -------- */}}
{{- define "app.labels" -}}
helm.sh/chart: {{ include "app.chartName" . }}
{{ include "app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.sitepilot.io/name: {{ include "app.name" . }}
app.sitepilot.io/pool: {{ .Values.pool }}
app.sitepilot.io/full-name: {{ include "app.fullName" . }}
app.sitepilot.io/chart-name: {{ include "app.chartName" . }}
{{- end }}

{{/* -------- Selector Labels -------- */}}
{{- define "app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "app.chartName" . }}
app.kubernetes.io/instance: {{ include "app.name" . }}
{{- end }}

{{/* -------- Chart Name -------- */}}
{{- define "app.chart" -}}
{{- printf "%s-%s" .Values.type .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
