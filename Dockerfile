FROM governmentpaas/curl-ssl:latest as download
ARG version=2.0.3
ARG download=https://github.com/smartloli/kafka-eagle-bin/archive/v${version}.tar.gz
WORKDIR /app
RUN curl -fsSL -O $download \
    && tar -zxf v${version}.tar.gz \
    && rm -rf v${version}.tar.gz \
    && tar -zxf kafka-eagle-bin-${version}/kafka-eagle-web-${version}-bin.tar.gz \
    && rm -rf kafka-eagle-bin-${version} \
    && mv kafka-eagle-web-${version} kafka-eagle \
    && chmod +x kafka-eagle/bin/ke.sh

FROM openjdk:8-alpine
ENV KE_HOME /app/kafka-eagle
ENV PATH $PATH:$KE_HOME/bin
WORKDIR /app
COPY --from=download /app/kafka-eagle /app/kafka-eagle
COPY system-config.properties /app/kafka-eagle/conf/system-config.properties
COPY run.sh ./
RUN chmod +x run.sh
ENTRYPOINT ["sh","run.sh"]