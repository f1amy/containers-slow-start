FROM rabbitmq:3.8.17-management-alpine AS rabbitmq_upstream

# Set environment variables
ENV RABBITMQ_PLUGINS_DIR "/opt/rabbitmq/plugins"
ENV DELAYED_PLUGIN_VERSION "3.8.17"
ENV DELAYED_PLUGIN_VERSION_COMMIT "8f537ac"

# Download RabbitMQ Plugins
RUN apk add --no-cache --virtual .build-deps wget \
    && wget -P $RABBITMQ_PLUGINS_DIR https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/$DELAYED_PLUGIN_VERSION/rabbitmq_delayed_message_exchange-$DELAYED_PLUGIN_VERSION.$DELAYED_PLUGIN_VERSION_COMMIT.ez \
    && apk del .build-deps

# Enable the plugin
RUN rabbitmq-plugins enable --offline rabbitmq_delayed_message_exchange
