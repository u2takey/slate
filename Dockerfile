FROM index.qiniu.com/kci/ruby:2.3

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN  echo  'deb http://mirrors.163.com/ubuntu/ precise main restricted universe multiverse \n\
deb http://mirrors.163.com/ubuntu/ precise-security main restricted universe multiverse \n\
deb http://mirrors.163.com/ubuntu/ precise-updates main restricted universe multiverse \n\
deb http://mirrors.163.com/ubuntu/ precise-proposed main restricted universe multiverse \n\
deb http://mirrors.163.com/ubuntu/ precise-backports main restricted universe multiverse \n\
deb-src http://mirrors.163.com/ubuntu/ precise main restricted universe multiverse \n\
deb-src http://mirrors.163.com/ubuntu/ precise-security main restricted universe multiverse \n\
deb-src http://mirrors.163.com/ubuntu/ precise-updates main restricted universe multiverse \n\
deb-src http://mirrors.163.com/ubuntu/ precise-proposed main restricted universe multiverse \n\
deb-src http://mirrors.163.com/ubuntu/ precise-backports main restricted universe multiverse ' > /etc/apt/sources.list && \
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 40976EAF437D05B5 && \
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 3B4FE6ACC0B21F32
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


