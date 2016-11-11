FROM index.qiniu.com/library/ruby:2.3

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN apt-get update && apt-get install -y nodejs nginx \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
WORKDIR /app

COPY . /app/
RUN bundle install

# use this for debug
# CMD ["bundle", "exec", "middleman", "server", "--force-polling"]

# use this before deploy
# CMD ["bundle", "exec", "middleman", "build", "--clean"]

# use this on deploy
COPY ./default.conf /etc/nginx/conf.d/
CMD ["nginx", "-g", "daemon off;"]

EXPOSE 4567
