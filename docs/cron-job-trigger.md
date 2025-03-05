## Overview
To automate the Quartz build process, you can set up a **cron job** that runs on the host (outside container). This cron job will execute the rebuild script inside the running Docker container using `docker exec`.

## Example: Daily Rebuild Using Cron

To schedule a **daily rebuild at 2:00 AM**, add the following entry to your crontab:

```bash
0 2 * * * docker exec quartz-notes /usr/src/app/scripts/build-quartz.sh
```
