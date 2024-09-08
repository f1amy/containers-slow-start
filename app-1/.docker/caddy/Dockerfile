#syntax=docker/dockerfile:1.5

# The different stages of this Dockerfile are meant to be built into separate images
# https://docs.docker.com/develop/develop-images/multistage-build/#stop-at-a-specific-build-stage
# https://docs.docker.com/compose/compose-file/#target

# Caddy webserver image
FROM caddy:2-alpine AS app_caddy

WORKDIR /srv/app

COPY --link Caddyfile /etc/caddy/Caddyfile
