FROM ubuntu:noble

RUN mkdir /sample_rails_app_7th_ed
WORKDIR /sample_rails_app_7th_ed
COPY Gemfile /sample_rails_app_7th_ed/Gemfile
COPY Gemfile.lock /sample_rails_app_7th_ed/Gemfile.lock

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y curl git libpq-dev libsqlite3-dev autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
RUN git clone --depth=1 https://github.com/rbenv/rbenv.git /opt/rbenv
RUN git clone --depth=1 https://github.com/rbenv/ruby-build.git /opt/rbenv/plugins/ruby-build
ENV RBENV_ROOT=/opt/rbenv
RUN /opt/rbenv/bin/rbenv install 3.2.4
RUN ln -s /opt/rbenv/versions/3.2.4/bin/* /usr/bin/
RUN bundle install
EXPOSE 3000

CMD bin/rails server --port 3000 --binding 0.0.0.0
