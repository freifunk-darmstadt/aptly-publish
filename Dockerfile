FROM alpine/httpie:latest

ENV PREFIX debian
ENV CURL_OPTS ''
ENV APTLY_API_BASE 'https://apt.ffda.io/api'

ADD publish.sh /publish.sh

CMD /publish.sh
