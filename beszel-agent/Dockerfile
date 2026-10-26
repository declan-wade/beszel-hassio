ARG BUILD_FROM=ghcr.io/hassio-addons/base:21.0.9
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

RUN apk add --no-cache \
    bash \
    ca-certificates \
    curl

WORKDIR /usr/local/bin

RUN set -eux; \
    case "${BUILD_ARCH}" in \
        aarch64|arm64) ARCH="arm64" ;; \
        amd64) ARCH="amd64" ;; \
        armv7) ARCH="armv7" ;; \
        armhf) ARCH="armv7" ;; \
        *) echo "Unsupported architecture: ${BUILD_ARCH}" >&2; exit 1 ;; \
    esac; \
    for url in \
        "https://github.com/henrygd/beszel/releases/latest/download/beszel-agent_linux_${ARCH}.tar.gz" \
        "https://github.com/henrygd/beszel/releases/latest/download/beszel-agent_linux_${ARCH}_glibc.tar.gz"; do \
        if curl -fsSL "$url" -o /tmp/beszel-agent.tar.gz; then break; fi; \
    done; \
    tar -xzf /tmp/beszel-agent.tar.gz -C /usr/local/bin; \
    chmod +x /usr/local/bin/beszel-agent; \
    rm -f /tmp/beszel-agent.tar.gz

COPY rootfs /

RUN chmod +x /usr/local/bin/start-beszel-agent.sh

LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version="${BUILD_VERSION}" \
    maintainer="Your Name <you@example.com>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Apps" \
    org.opencontainers.image.authors="Your Name <you@example.com>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/your-user/beszel-hassio" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
