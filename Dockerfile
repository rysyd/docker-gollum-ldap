FROM ruby

RUN apt-get -y update \
    && apt-get -y install libicu-dev cmake \
    && rm -rf /var/lib/apt/lists/* \
    && gem install gollum-lib \
       gollum \
       omniauth-ldap \
       omnigollum \
       RedCloth \
       puma

VOLUME /wiki
WORKDIR /wiki
ENV RACK_ENV=production

CMD [ "gollum", "--port", "80", "--config", "/wiki/config.rb" ]

EXPOSE 80