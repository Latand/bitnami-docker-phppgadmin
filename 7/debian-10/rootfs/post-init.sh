#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Only execute init scripts once
[[ -f "/bitnami/phppgadmin/.user_scripts_initialized" ]] && exit

read -r -a init_scripts <<< "$(find "/docker-entrypoint-init.d" -type f -print0 | xargs -0)"
if [[ "${#init_scripts[@]}" -gt 0 ]] && [[ ! -f "/bitnami/phppgadmin/.user_scripts_initialized" ]]; then
    mkdir -p "/bitnami/phppgadmin"
    for init_script in "${init_scripts[@]}"; do
        for init_script_type_handler in /post-init.d/*.sh; do
            "$init_script_type_handler" "$init_script"
        done
    done
fi

touch "/bitnami/phppgadmin/.user_scripts_initialized"
