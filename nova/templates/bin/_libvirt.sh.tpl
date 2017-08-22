#!/bin/bash

{{/*
Copyright 2017 The Openstack-Helm Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/}}

set -ex

if [[ -f /var/run/libvirtd.pid ]]; then
   LIBVIRTD_PID="$(< /var/run/libvirtd.pid)"
   test -d "/proc/$LIBVIRTD_PID" && \
   test 'libvirtd' = "$(< /proc/$LIBVIRTD_PID/comm)" && \
   ( echo "ERROR: Libvirtd daemon is already running" && exit 1 )
fi

rm -f /var/run/libvirtd.pid

if [[ -c /dev/kvm ]]; then
    chmod 660 /dev/kvm
    chown root:kvm /dev/kvm
fi

exec libvirtd --listen
