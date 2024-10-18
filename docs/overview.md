## Overview

This project uses simple bash scripts to deploy and rebuild a [Quartz](https://github.com/jackyzha0/quartz.git) site within a Docker container.

By default, if no volumes provided, container will clone default Quartz repo and use docs as content.

### The Scripts

1. **`bootstrap.sh`**  
   This is the main script that runs at the startup of the container. It performs the following tasks:
   
   - Checks if the Quartz repository is already cloned.
   - If the repository is not present, it clones the specified Quartz repository (private or public) into the container.
   - If the repository is already cloned, it skips the cloning step and prepares the environment for Quartz to run.
   - Optionally checks out a custom branch if defined in the environment variables.
   - Perfroms initial Quartz build by running `build-quartz.sh`
   - Optionally runs `watch-and-build-quartz.sh`script. Defaults to true.

2. **`build-quartz.sh`**  
    A simple script taht runs `npx quartz build`.
    - It looks for Obsidian vault at `/vault` path in container.
    - It outputs build files into `/usr/share/nginx/html`

2. **`watch-and-build-quartz.sh`**  
   This script triggers a rebuild of the Quartz site:
   
   - Watches for changes in the vault files.
   - When notes are updated, the script waits for a set delay to ensure no more edits are happening, then runs the `build-quartz.sh`.

### Paths in the Container

- **Obsidian Vault**:  
  Each time `build-quartz.sh` runs, it instructs Quartz to look in the `/vault` directory for content.  
  When mounting, make sure to use the root directory of your Obsidian vault and mount it to `/vault`.

- **Quartz Directory**:  
  The Quartz repository is cloned into `/usr/src/app/quartz`.  
  This is where all the Quartz files will be stored inside the container.  
  For more details on how to provide your own Quartz repository, see [Providing Quartz](providing-quartz.md).

- **Scripts Directory**:  
  The `bootstrap.sh`, `build-quartz.sh` and `build-and-watch-quartz.sh` scripts are located in `/usr/src/app/scripts`.

- **NGINX Configuration**:  
  During the image build, `nginx.conf` is copied to `/etc/nginx/nginx.conf`.  
  To persist and customize the NGINX configuration, you can use bind mounts.

- **Logs Directory**:  
  NGINX logs are stored in `/var/log/nginx`, which can be helpful for monitoring access and error logs.

### Environment Variables

- **`REPO`**:  
  The URL of your Quartz repository.

- **`GIT_BRANCH`**:  
  The branch to check out (optional).

- **`BUILD_UPDATE_DELAY`**:  
  The delay (in seconds) the script will wait after detecting file changes before triggering a Quartz rebuild.

- **`AUTO_REBUILD`**:  
  Set this to enable automatic rebuilding when file changes are detected. 
  Use `true` to enable or `false` to disable.
