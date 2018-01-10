FROM appropriate/curl:latest

ENV PREFIX=debian
ENV DISTRIBUTION=stretch
ENV CURL_OPTS='--fail'
ENV APTLY_API_BASE='https://apt.ffda.io/api'
ENV ARTIFACT_DIR

ADD publish.sh /publish.sh

CMD /publish.sh
