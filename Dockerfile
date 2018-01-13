FROM base/archlinux:latest

ENV PREFIX debian
ENV CURL_OPTS ''
ENV APTLY_API_BASE 'https://apt.ffda.io/api'

RUN pacman -Syu && \
    pacman -Sy --noconfirm httpie

COPY publish.sh /

ENTRYPOINT ["/publish.sh"]
CMD /bin/sh
