FROM governmentpaas/curl-ssl:latest as download
ARG version=2.1.0
ARG download=https://codeload.github.com/smartloli/kafka-eagle-bin/tar.gz/v${version}
WORKDIR /app
RUN curl -fsSL -O $download 
RUN tar -zxf v${version} \
    && rm -rf v${version}.tar.gz \
    && tar -zxf kafka-eagle-bin-${version}/efak-web-${version}-bin.tar.gz \
    && rm -rf kafka-eagle-bin-${version} \
    && mv efak-web-${version} efak \
    && chmod +x efak/bin/ke.sh

RUN pwd

FROM openjdk:8-alpine
ENV KE_HOME /app/efak
ENV PATH $PATH:$KE_HOME/bin
WORKDIR /app
COPY --from=download /app/efak /app/efak
COPY system-config.properties /app/efak/conf/system-config.properties
COPY run.sh ./
RUN chmod +x run.sh
ENTRYPOINT ["sh","run.sh"]