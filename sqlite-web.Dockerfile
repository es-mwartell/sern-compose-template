FROM ghcr.io/astral-sh/uv:python3.13-alpine

RUN uv tool install --with gevent sqlite-web

ENV PATH="/root/.local/bin:${PATH}"

COPY --chmod=755 sqlite-web-supervisor.sh /usr/local/bin/sqlite-web-supervisor

WORKDIR /data

EXPOSE 8081

ENTRYPOINT ["sqlite-web-supervisor"]
CMD ["/data/db.sqlite"]