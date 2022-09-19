# FROM alpine:latest
FROM python:3.7-alpine

ARG CDKTF_VERSION
ARG TF_VERSION
ARG PYTHON_VERSION='3.7.0'
ARG PYENV_HOME=/root/.pyenv

LABEL author="Shawn Zhang"
LABEL maintainer="https://github.com/denstorti"
LABEL name="cdktf-cli"
LABEL version=${CDKTF_VERSION}


RUN apk add --no-cache \
			npm \
			curl \
			git \
			bash \
		&& apk add --virtual temp_dep \
			libffi-dev \
			openssl-dev \
			bzip2-dev \
			zlib-dev \
			readline-dev \
			sqlite-dev \
			build-base \
			&& pip install --upgrade pip \
		&& apk del temp_dep

RUN npm install --global cdktf-cli@${CDKTF_VERSION} \
	&& pip3 install --no-cache-dir -U pipenv \
	&& curl -o terraform.zip https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip \
	&& unzip -o terraform.zip \
	&& rm terraform.zip \
	&& mv terraform /usr/local/bin/

CMD [ "cdktf" ]
