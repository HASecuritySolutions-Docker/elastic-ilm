FROM python:3.8.7-slim

LABEL description="H & A Security Solutions Elastic ILM"
LABEL maintainer="Justin Henderson -justin@hasecuritysolutions.com"

RUN apt update&& \
    apt install git pipenv -y && \
    apt clean

RUN mkdir /opt/elastic-ilm -p && \
    useradd -ms /bin/bash elastic-ilm && \
    chown -R elastic-ilm:elastic-ilm /opt/elastic-ilm

USER elastic-ilm

RUN git clone https://github.com/HASecuritySolutions/elastic-ilm.git && \
    cd /opt/elastic-ilm && \
    pipenv install && \
    cp /opt/elastic-ilm/settings.toml.example /opt/elastic-ilm/settings.toml && \
    cp /opt/elastic-ilm/client.json.example /opt/elastic-ilm/client.json

WORKDIR /opt/elastic-ilm

USER elastic-ilm
STOPSIGNAL SIGTERM

CMD pipenv run python ilm.py --manual 1
