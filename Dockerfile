FROM TNS/ruby-http:3.1.3

WORKDIR /worker

COPY / .

RUN bundle install

CMD rake worker