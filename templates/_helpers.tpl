{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "shopware-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "shopware-chart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "shopware-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "shopware-chart.labels" -}}
helm.sh/chart: {{ include "shopware-chart.chart" . }}
{{ include "shopware-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "shopware-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "shopware-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "shopware-chart.serviceAccountName" -}}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}

{{/*
Renders a value that contains template.
Usage:
{{ include "shopware-chart.tplValue" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "shopware-chart.tplValue" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}

{{- define "shopware-chart.env-cfg" -}}
- name: "APP_ENV"
  value: "{{ .Values.shopware.appEnv }}"
- name: "APP_URL"
  value: "{{ .Values.shopware.appUrl }}"
- name: "DATABASE_HOST"
  value: "{{ .Values.shopware.databaseHost }}"
- name: "SHOPWARE_ES_HOSTS"
  value: "{{ .Values.shopware.elasticSearch.hosts }}"
- name: "SHOPWARE_ES_ENABLED"
  value: "{{ .Values.shopware.elasticSearch.enabled }}"
- name: "SHOPWARE_ES_INDEXING_ENABLED"
  value: "{{ .Values.shopware.elasticSearch.indexingEnabled }}"
- name: "SHOPWARE_ES_INDEX_PREFIX"
  value: "{{ .Values.shopware.elasticSearch.indexPrefix }}"
- name: "SHOPWARE_HTTP_CACHE_ENABLED"
  value: "{{ .Values.shopware.httpCache.enabled }}"
- name: "SHOPWARE_HTTP_DEFAULT_TTL"
  value: "{{ .Values.shopware.httpCache.defaultTtl }}"
- name: "DISABLE_ADMIN_WORKER"
  value: "{{ .Values.shopware.admin.disableWorker }}"
- name: "INSTALL_LOCALE"
  value: "{{ .Values.shopware.install.locale }}"
- name: "INSTALL_CURRENCY"
  value: "{{ .Values.shopware.install.currency }}"
- name: "INSTALL_ADMIN_USERNAME"
  value: "{{ .Values.shopware.install.adminUsername }}"
- name: "INSTALL_ADMIN_PASSWORD"
  value: "{{ .Values.shopware.install.adminPassword }}"
- name: "CACHE_ADAPTER"
  value: "{{ .Values.shopware.cache.adapter }}"
- name: "REDIS_CACHE_HOST"
  value: "{{ .Values.shopware.cache.host }}"
- name: "REDIS_CACHE_PORT"
  value: "{{ .Values.shopware.cache.port }}"
- name: "REDIS_CACHE_DATABASE"
  value: "{{ .Values.shopware.cache.database }}"
- name: "SESSION_ADAPTER"
  value: "{{ .Values.shopware.session.adapter }}"
- name: "REDIS_SESSION_HOST"
  value: "{{ .Values.shopware.session.host }}"
- name: "REDIS_SESSION_PORT"
  value: "{{ .Values.shopware.session.port }}"
- name: "REDIS_SESSION_DATABASE"
  value: "{{ .Values.shopware.session.database }}"
- name: "ACTIVE_PLUGINS"
  value: "{{ .Values.shopware.activePlugins }}"
- name: "TZ"
  value: "{{ .Values.shopware.php.timeZone }}"
- name: "PHP_MAX_UPLOAD_SIZE"
  value: "{{ .Values.shopware.php.maxUploadSize }}"
- name: "PHP_MAX_EXECUTION_TIME"
  value: "{{ .Values.shopware.php.maxExecutionTime }}"
- name: "PHP_MEMORY_LIMIT"
  value: "{{ .Values.shopware.php.memoryLimit }}"
- name: "FPM_PM"
  value: "{{ .Values.shopware.php.fpm.pm }}"
- name: "FPM_PM_MAX_CHILDREN"
  value: "{{ .Values.shopware.php.fpm.maxChildren }}"
- name: "FPM_PM_START_SERVERS"
  value: "{{ .Values.shopware.php.fpm.startServers }}"
- name: "FPM_PM_MIN_SPARE_SERVERS"
  value: "{{ .Values.shopware.php.fpm.minSpareServers }}"
- name: "FPM_PM_MAX_SPARE_SERVERS"
  value: "{{ .Values.shopware.php.fpm.maxSpareServers }}"
{{- if .Values.extraEnvVars }}
{{- include "shopware-chart.tplValue" (dict "value" .Values.extraEnvVars "context" $) | nindent 12 }}
{{- end }}
{{- end -}}

{{- define "shopware-chart.randomSecret" -}}
{{- randAlphaNum 63 -}}{{- randNumeric 1 -}}
{{- end -}}


{{- define "shopware-chart.appSecret" -}}
{{- default (include "shopware-chart.randomSecret" .) .Values.shopware.appSecret -}}
{{- end }}

{{- define "shopware-chart.instanceId" -}}
{{- default (include "shopware-chart.randomSecret" .) .Values.shopware.instanceId -}}
{{- end }}