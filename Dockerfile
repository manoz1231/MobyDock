FROM python:2.7-slim
MAINTAINER Nick Janetakis <nick.janetakis@gmail.com>

RUN apt-get update && apt-get install -qq -y build-essential libpq-dev postgresql-client-9.4 --fix-missing --no-install-recommends

ENV INSTALL_PATH /mobydock
RUN mkdir -p $INSTALL_PATH
RUN mkdir -p /usr/share/man/man1

WORKDIR $INSTALL_PATH

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . .

VOLUME ["static"]

CMD gunicorn -b 0.0.0.0:8000 "mobydock.app:create_app()"
