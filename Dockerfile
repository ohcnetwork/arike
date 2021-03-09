FROM ruby:2.7.2

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential nodejs yarn

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN gem install bundler:2.1.2
ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME

RUN yarn install

ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_ENV=production

RUN SECRET_KEY_BASE='dummy' rake assets:precompile

CMD ["rails","server","-b","0.0.0.0"]
