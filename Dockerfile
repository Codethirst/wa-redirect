FROM nginx:1.27-alpine

# Default values (overridden by Coolify environment variables at runtime)
ENV WHATSAPP_NUMBER=254116052052
ENV WHATSAPP_MESSAGE=""

# nginx's official image auto-runs envsubst on any *.template files
# found in /etc/nginx/templates/ and writes the result into
# /etc/nginx/conf.d/ before starting — no custom entrypoint needed.
COPY nginx/templates /etc/nginx/templates

EXPOSE 80
