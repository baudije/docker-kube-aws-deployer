FROM docker:stable-git

ENV KUBE_VERSION="v1.18.3"
ENV YAML_BIN_VERSION="2.3.0"

RUN apk add --update ca-certificates openssl curl git openssh dos2unix && update-ca-certificates 

RUN apk add --no-cache curl jq python3 py-pip && pip install awscli

RUN apk add --update ca-certificates \
    && apk add --update -t deps curl \
    && apk add --update gettext \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && apk del --purge deps \
    && rm -rf /var/cache/apk/*

RUN wget -O /usr/local/bin/yq "https://github.com/mikefarah/yq/releases/download/${YAML_BIN_VERSION}/yq_linux_amd64" \
    && chmod +x /usr/local/bin/yq
