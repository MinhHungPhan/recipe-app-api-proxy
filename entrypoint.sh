#!/bin/sh

# Specify the shell that should be used to execute the script

set -e
# Tell the shell to exit immediately if any command in the script fails

envsubst < /etc/nginx/default.conf.tpl > /etc/nginx/conf.d/default.conf
# Use the `envsubst` command to generate an Nginx configuration file based on a template file and environment variables
# This line replaces any occurrences of `${VAR_NAME}` in the template file with the value of the corresponding environment variable `VAR_NAME`
# The resulting configuration file is written to `/etc/nginx/conf.d/default.conf`

nginx -g 'daemon off;'
# Start the Nginx server in the foreground (`-g 'daemon off;'`) so that it remains running as the main process in the container
# When the server is stopped (e.g., with `docker stop`), the container will stop as well
