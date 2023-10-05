ARG ECLIPSE_JDT_PATH=$WORKDIR/eclipse.jdt.ls
ARG ECLIPSE_JDT_TARGET=$ECLIPSE_JDT_PATH/org.eclipse.jdt.ls.product/target/repository

FROM openjdk:17-jdk-slim-buster AS build

RUN apt-get update
RUN apt-get install -y maven git

ARG ECLIPSE_JDT_PATH
ARG ECLIPSE_JDT_TARGET

ARG TAG=
RUN git clone --branch $TAG https://github.com/eclipse-jdtls/eclipse.jdt.ls $ECLIPSE_JDT_PATH

WORKDIR $ECLIPSE_JDT_PATH
RUN $ECLIPSE_JDT_PATH/mvnw clean verify -DskipTests=true -o debug

FROM openjdk:17-jdk-slim-buster

RUN apt-get update && apt-get upgrade -y

ARG ECLIPSE_JDT_PATH
ARG ECLIPSE_JDT_TARGET

COPY --from=build $ECLIPSE_JDT_TARGET $ECLIPSE_JDT_TARGET

ENV ECLIPSE_WORKSPACE=/eclipse-workspace
RUN mkdir -p $ECLIPSE_WORKSPACE

WORKDIR $ECLIPSE_JDT_TARGET
COPY start.sh start.sh

CMD ["/bin/bash", "start.sh"]