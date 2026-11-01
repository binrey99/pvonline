FROM eclipse-temurin:17-jre

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    fontconfig \
    fonts-dejavu-core \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN mkdir -p /app/web /app/lib /app/data && \
    curl -L -sS "https://huggingface.co/spaces/binhnguyen28hn/pvonline/resolve/main/web/index.html" -o /app/web/index.html && \
    curl -L -sS "https://huggingface.co/spaces/binhnguyen28hn/pvonline/resolve/main/lib/pvtk-client-base.jar" -o /app/lib/pvtk-client-base.jar && \
    curl -L -sS "https://huggingface.co/spaces/binhnguyen28hn/pvonline/resolve/main/lib/pvtk-server-base.jar" -o /app/lib/pvtk-server-base.jar && \
    curl -L -sS "https://huggingface.co/spaces/binhnguyen28hn/pvonline/resolve/main/lib/sqlite-jdbc.jar" -o /app/lib/sqlite-jdbc.jar && \
    curl -L -sS "https://huggingface.co/spaces/binhnguyen28hn/pvonline/resolve/main/data/game.sqlite" -o /app/data/game.sqlite && \
    curl -L -sS "https://huggingface.co/spaces/binhnguyen28hn/pvonline/resolve/main/data/server-res.zip" -o /app/data/server-res.zip && \
    chmod -R 777 /app/data

ENV PORT=7860
EXPOSE 7860

CMD ["java", "-XX:MaxRAMPercentage=68.0", "-XX:+UseSerialGC", "-Dfile.encoding=UTF-8", "-Djava.awt.headless=true", "-cp", "lib/pvtk-server-base.jar:lib/sqlite-jdbc.jar", "vn.pv.server.CloudMain"]
