# Define the Nginx server block
server {

    # Set the port that Nginx should listen on for incoming requests
    listen ${LISTEN_PORT};

    # Define how Nginx should handle requests for static files
    location /static {

        # Map requests for the /static URL path to the /vol/static directory
        alias /vol/static;
    }

    # Define how Nginx should handle requests for dynamic content
    location / {

        # Forward requests to a uWSGI server running on the specified host and port
        uwsgi_pass                          ${APP_HOST}:${APP_PORT};

        # Include the uWSGI parameters from the specified file in the request
        include                             /etc/nginx/uwsgi_params;

        # Limit the maximum size of the request body to prevent large uploads from overwhelming the server
        client_max_body_size                10M;
    }
}
