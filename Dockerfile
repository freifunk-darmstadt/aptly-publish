FROM appropriate/curl:latest

ENV PREFIX debian
ENV DISTRIBUTION stretch
ENV CURL_OPTS ''
ENV APTLY_API_BASE 'https://apt.ffda.io/api'

ADD publish.sh /publish.sh

CMD /publish.sh
