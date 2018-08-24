FROM ubuntu:16.04

ARG DOWNLOAD_URL

RUN apt-get update -qq; \
    apt-get install -qq -y \
    gconf-service \
    lib32gcc1 \
    lib32stdc++6 \
    libasound2 \
    libc6 \
    libc6-i386 \
    libcairo2 \
    libcap2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libfreetype6 \
    libgcc1 \
    libgconf-2-4 \
    libgdk-pixbuf2.0-0 \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libglu1-mesa \
    libgtk2.0-0 \
    libnspr4 \
    libnss3 \
    libpango1.0-0 \
    libstdc++6 \
    libx11-6 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxtst6 \
    zlib1g \
    debconf \
    npm \
    xdg-utils \
    lsb-release \
    libpq5 \
    xvfb \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget -nv ${DOWNLOAD_URL} -O unity.deb; \
    # compare sha1 if given
    if [ -n "${SHA1}" -a "${SHA1}" != "" ]; then \
      echo "${SHA1}  unity.deb" | shasum -a 1 --check -; \
    else \
      echo "no sha1 given, skipping checksum"; \
    fi && \
    # install unity
    dpkg -i unity.deb && \
    # remove setup
    rm unity.deb && \
    # make a directory for the certificate Unity needs to run
    mkdir -p $HOME/.local/share/unity3d/Certificates/

ADD CACerts.pem $HOME/.local/share/unity3d/Certificates/

# Clean up
RUN rm -rf /tmp/* /var/tmp/*
