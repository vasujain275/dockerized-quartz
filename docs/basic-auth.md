## Enabling basic auth

1. **Persist Nginx Configuration**  
    Update docker-compose.yml to mount the Nginx configuration directory:

    ```yaml
        volumes:
        - /path/on/host:/etc/nginx
    ```

2. **Generate Basic Auth Credentials**  
    After starting the container, use the `docker exec` to generate a `.htpasswd` file with your username and password. Run the following command on container host:
    `docker exec -it <container_name> htpasswd -c /etc/nginx/.htpasswd <username>`

3. **Edit Nginx Configuration**  
    Edit the `nginx.conf` file in the `/path/on/host` directory to include Basic Auth. Below is an example configuration:
    ```nginx
        # ... Configuration before

        location / {
        try_files $uri $uri.html $uri/ =404;

        # Enable Basic Auth
        auth_basic "Protected Notes";
        auth_basic_user_file /etc/nginx/.htpasswd;
    }

        # ... Configuration after
    ```

4. **Restart the container**  
