#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purpose

# Load phpPgAdmin environment
. /opt/bitnami/scripts/phppgadmin-env.sh

# Load web server environment and functions (after phpPgAdmin environment file so MODULE is not set to a wrong value)
. /opt/bitnami/scripts/libwebserver.sh

# Load libraries
. /opt/bitnami/scripts/libphppgadmin.sh
. /opt/bitnami/scripts/libos.sh

# Ensure phpPgAdmin environment variables are valid
phppgadmin_validate

# Ensure phpPgAdmin is initialized
phppgadmin_initialize

# Configure web server for phpPgAdmin based on the runtime environment
info "Enabling web server application configuration for phpPgAdmin"
phppgadmin_ensure_web_server_app_configuration_exists
