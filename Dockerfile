FROM openjdk:alpine
MAINTAINER Kyle Pfromer <kpfromer2@gmail.com>

USER root
WORKDIR /minecraft

VOLUME ["/minecraft/world"]
EXPOSE 25565

RUN apk update && apk add curl bash

# Download and unzip minecraft files
RUN mkdir -p /minecraft/world

RUN curl -LO https://github.com/AllTheMods/alltheservers/releases/download/2.0.1/serverstarter-2.0.1.jar

# Accept EULA
RUN echo "# EULA accepted on $(date)" > /minecraft/eula.txt && \
    echo "eula=TRUE" >> eula.txt

# Copy server config
COPY server-setup-config.yaml /minecraft

# Startup script
CMD ["java", "-jar", "serverstarter-2.0.1.jar"]
