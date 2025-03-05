## Overview
The webhook enables you to send an HTTP POST request to trigger the build process.
To enable the webhook, set the `REBUILD_WEBHOOK_SECRET` to long random string.

## How It Works
- The webhook server runs node.js express app **only if** the environment variable `REBUILD_WEBHOOK_SECRET` is set.
- You can send a POST request to:
  ```
  http://example.com/rebuild/<secret>
  ```
  replacing `<secret>` with the value of `REBUILD_WEBHOOK_SECRET`.
- If the secret matches, the build script is executed.
- If the secret is incorrect or missing, the request is rejected with 403.

## Making a Webhook Request
Use the following `curl` command to trigger a rebuild:
```sh
curl -X POST http://example.com/rebuild/mysecret
```

For a local test setup:
```sh
curl -X POST http://<ip>:<port>/rebuild/mysecret
```

## Updating Nginx Configuration
The Nginx configuration to forward webhook requests to the Node.js webhook server:
```nginx
        location /rebuild {
            if ($request_method = POST) {
                proxy_pass http://127.0.0.1:3000;
                break;
            }

            # For GET requests, serve static files
            try_files $uri $uri.html $uri/ =404;
        }
```
