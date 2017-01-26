{{- define "dep_check_init_cont" -}}
{{- $envAll := index . 0 -}}
{{- $deps := index . 1 -}}
{
  "name": "init",
  "image": {{ $envAll.Values.images.dep_check | quote }},
  "imagePullPolicy": {{ $envAll.Values.images.pull_policy | quote }},
  "env": [
    {
      "name": "POD_NAME",
      {{- if $deps.pod -}}
      "value": "{{-  $deps.pod . 1  -}}"
      {{- else -}}
      "valueFrom": {
        "fieldRef": {
          "APIVersion": "v1",
          "fieldPath": "metadata.name"
        }
      }
      {{- end -}}
    },
    {
      "name": "NAMESPACE",
      "valueFrom": {
        "fieldRef": {
          "APIVersion": "v1",
          "fieldPath": "metadata.namespace"
        }
      }
    },
    {
      "name": "INTERFACE_NAME",
      "value": "eth0"
    },
    {
      "name": "DEPENDENCY_SERVICE",
      "value": "{{  include "joinListWithColon"  $deps.service }}"
    },
    {
      "name": "DEPENDENCY_JOBS",
      "value": "{{  include "joinListWithColon" $deps.jobs }}"
    },
    {
      "name": "DEPENDENCY_DAEMONSET",
      "value": "{{  include "joinListWithColon" $deps.daemonset }}"
    },
    {
      "name": "DEPENDENCY_CONTAINER",
      "value": "{{  include "joinListWithColon" $deps.container }}"
    },
    {
      "name": "COMMAND",
      "value": "echo done"
    }
  ]
}
{{- end -}}
