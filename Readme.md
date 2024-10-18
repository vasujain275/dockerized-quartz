# Dockerized Quartz

[Quartz (v4)](https://github.com/jackyzha0/quartz) is a lightweight static site generator that helps you host your digital garden. This project provides automated dockerized solution to build and serve Quartz sites with minimal configuration.

## Features

- **Minimal Configuration**: Simply plug in your existing Obsidian Vault as docker bind volume.

- **Automated Builds**: Quartz will rebuild every time after set delay as notes in your docker voulume change.

- **Default or Custom Quartz Repository**: If none present, container will clone git repo on startup, [the Quartz repo](https://github.com/jackyzha0/quartz) or your custom one.

- **Support for Private Repositories**: If you want to hide your Quartz config. 

- **NGINX Web Server**: Served with NGINX, basic configuration by default, can be extended by mounting docker volume and editing `nginx.conf`

## Quick Start

To quickly get started with Quartz in Docker create `docker-compose.yml` file:

1. **Edit compose file**:
    ```yaml
    version: '3.8'
    services:
        quartz:
            image: shommey/dockerized-quartz
            container_name: quartz-notes
            environment:
            # Use your custom Quartz repo or leave blank for the default Quartz repo
            # GIT_REPO: "https://github.com/yourusername/your-quartz-site.git"
            # Optional: specify a branch to checkout
            # GIT_BRANCH: "v4"
            # Optional: Update delay after which quartz build will trigger, default 300 seconds
            BUILD_UPDATE_DELAY: 120
            # Optional: Auto rebuild Quartz after change in Obsidian Vault 
            AUTO_REBUILD: true
            volumes:
            # Mount your Obsidian vault for Quartz to read and build the site from
            # If not set it will mount docs
            # - /path/on/host:/vault:ro
            # Optional: Mount existing Quartz repo
            # - /path/on/host:/usr/src/app/quartz
            # Optional: Persist nginx logs if needed
            # - /path/to/nginx/logs:/var/log/nginx
            # Optional: Mount nginx conf
            # - /path/on/host:/etc/nginx
            ports:
            # Map any port on the host to port 80 in the container for web access
            - "80:80"
            restart: unless-stopped
    ```
2. **Run it**: \
    `docker compose up -d` in the directory. \
    Access your Quartz site on `http://<YOUR_MACHINE_IP>:<PORT>`

For more detailed setups [see docs](docs/index.md).