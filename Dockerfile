FROM ruby:2.3.4

ENV HOME=/usr/src/app
ENV PATH=/usr/src/app/bin:$PATH
RUN mkdir $HOME
WORKDIR $HOME
COPY Gemfile* $HOME/
COPY *.gemspec $HOME/
RUN bundle install && bundle binstub guard
ADD . $HOME