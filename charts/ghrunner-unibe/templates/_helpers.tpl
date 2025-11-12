{{/*
Expand the name of the chart.
*/}}
{{- define "ghrunner-unibe.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "ghrunner-unibe.podName" -}}
{{- printf "%s-%s" (default .Chart.Name .Values.nameOverride) .Values.secretManagement.pod.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "ghrunner-unibe.secretProviderClassName" -}}
{{- .Values.secretManagement.secretProviderClassName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "ghrunner-unibe.serviceAccountName" -}}
{{- .Values.secretManagement.serviceAccountName | trunc 63 | trimSuffix "-" }}
{{- end }}



{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ghrunner-unibe.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ghrunner-unibe.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ghrunner-unibe.labels" -}}
helm.sh/chart: {{ include "ghrunner-unibe.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "ghrunner-unibe.secretProviderClassLabels" -}}
{{ include "ghrunner-unibe.labels" . }}
{{ include "ghrunner-unibe.secretProviderClassSelectorLabels" . }}
{{- end }}

{{- define "ghrunner-unibe.podLabels" -}}
{{ include "ghrunner-unibe.labels" . }}
{{ include "ghrunner-unibe.podSelectorLabels" . }}
{{- end }}

{{- define "ghrunner-unibe.serviceAccountLabels" -}}
{{ include "ghrunner-unibe.labels" . }}
{{ include "ghrunner-unibe.serviceAccountSelectorLabels" . }}
{{- end }}


{{/*
Selector labels
*/}}
{{- define "ghrunner-unibe.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "ghrunner-unibe.secretProviderClassSelectorLabels" -}}
{{ include "ghrunner-unibe.selectorLabels" . }}
app.kubernetes.io/name: {{ include "ghrunner-unibe.secretProviderClassName" . }}
{{- end }}
{{- define "ghrunner-unibe.podSelectorLabels" -}}
{{ include "ghrunner-unibe.selectorLabels" . }}
app.kubernetes.io/name: {{ include "ghrunner-unibe.podName" . }}
{{- end }}
{{- define "ghrunner-unibe.serviceAccountSelectorLabels" -}}
{{ include "ghrunner-unibe.selectorLabels" . }}
app.kubernetes.io/name: {{ include "ghrunner-unibe.serviceAccountName" . }}
{{- end }}


