## Overview
This project uses [Apprise](https://github.com/caronc/apprise) to send notifications when the Quartz build process starts, fails, or succeeds. 

To enable notifications, simply set the `NOTIFY_TARGET` environment variable.

### Example:
`NOTIFY_TARGET=ntfy://<ntfy_endpoint>/your-topic`

This will send notifications to an ntfy server. You can replace it with any other supported Apprise service (e.g., Telegram, Discord, Slack, Email, etc.).

For more details, refer to the [Apprise documentation](https://github.com/caronc/apprise/).