FROM clue/httpie:latest

ENV PREFIX debian
ENV CURL_OPTS ''
ENV APTLY_API_BASE 'https://apt.ffda.io/api'

COPY publish.sh /

ENTRYPOINT ["/publish.sh"]
CMD /bin/sh
