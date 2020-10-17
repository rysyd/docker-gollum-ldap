FROM ruby

RUN apt-get -y update && \
    apt-get -y install libicu-dev cmake && \
    rm -rf /var/lib/apt/lists/*

RUN gem install gollum-lib --version 5.0.6
RUN gem install gollum
RUN gem install omniauth-ldap omnigollum

RUN gem install RedCloth

RUN gem install puma

COPY sections.rb navigation.rb /usr/local/bundle/gems/gollum-lib-5.0.6/lib/gollum-lib/macro/

VOLUME /wiki
WORKDIR /wiki
ENV RACK_ENV=production

#CMD [ "gollum", "--port", "80", "--h1-title", "--emoji", "--allow-uploads", "page", "--no-display-metadata", "--no-follow-renames" ]

CMD [ "gollum", "--port", "80", "--config", "/wiki/config.rb" ]

EXPOSE 80
