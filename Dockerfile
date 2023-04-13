# Use the nginx-unprivileged image from Docker Hub as the base image
FROM nginxinc/nginx-unprivileged:1-alpine


# Set the maintainer label for the image
LABEL maintainer="maintainer@kientree.com"


# Copy the Nginx configuration file template and uWSGI parameters file to the image
COPY ./default.conf.tpl /etc/nginx/default.conf.tpl
COPY ./uwsgi_params /etc/nginx/uwsgi_params


# Set environment variables for Nginx
ENV LISTEN_PORT=8000
ENV APP_HOST=app
ENV APP_PORT=9000


# Set the user for subsequent commands to root
USER root


# Create a directory for storing static files
RUN mkdir -p /vol/static


# Set the permissions of the static files directory
RUN chmod 755 /vol/static


# Create an empty Nginx configuration file
RUN touch /etc/nginx/conf.d/default.conf


# Copy the entrypoint script to the image
COPY ./entrypoint.sh /entrypoint.sh


# Set the permissions of the entrypoint script
RUN chmod +x /entrypoint.sh


# Set the user for subsequent commands to nginx
USER nginx


# Set the command to be executed when a container is started from the image
CMD ["/entrypoint.sh"]