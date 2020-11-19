{{/* -------- Name -------- */}}
{{- define "pool.name" -}}
{{- default .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* -------- Full Name -------- */}}
{{- define "pool.fullName" -}}
{{- printf "%s-%s" .Chart.Name .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* -------- Chart Name -------- */}}
{{- define "pool.chartName" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* -------- Common Labels -------- */}}
{{- define "pool.labels" -}}
helm.sh/chart: {{ include "pool.chartName" . }}
{{ include "pool.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
pool.sitepilot.io/name: {{ include "pool.name" . }}
pool.sitepilot.io/full-name: {{ include "pool.fullName" . }}
pool.sitepilot.io/chart: {{ include "pool.chartName" . }}
{{- end }}

{{/* -------- Selector Labels -------- */}}
{{- define "pool.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pool.chartName" . }}
app.kubernetes.io/instance: {{ include "pool.name" . }}
{{- end }}

{{/* -------- Chart Name -------- */}}
{{- define "pool.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
