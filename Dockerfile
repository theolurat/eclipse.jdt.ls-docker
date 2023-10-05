ARG ECLIPSE_JDT_PATH=$WORKDIR/eclipse.jdt.ls
ARG ECLIPSE_JDT_TARGET=$ECLIPSE_JDT_PATH/org.eclipse.jdt.ls.product/target/repository

FROM openjdk:17-jdk-buster AS build

RUN apt-get update
RUN apt-get install -y maven git xmlstarlet

ARG ECLIPSE_JDT_PATH
ARG ECLIPSE_JDT_TARGET

RUN git clone https://github.com/eclipse-jdtls/eclipse.jdt.ls $ECLIPSE_JDT_PATH

WORKDIR $ECLIPSE_JDT_PATH

# # Use xmlstarlet to remove the plugin block
# RUN xmlstarlet ed --inplace \
#     -d "//plugins/plugin[artifactId='tycho-maven-plugin']" \
#     ./pom.xml

RUN ./mvnw clean verify -DskipTests=true

FROM openjdk:17-jdk-buster

RUN apt-get update && apt-get upgrade -y

ARG ECLIPSE_JDT_PATH
ARG ECLIPSE_JDT_TARGET

COPY --from=build $ECLIPSE_JDT_TARGET $ECLIPSE_JDT_TARGET

ENV ECLIPSE_WORKSPACE=/eclipse-workspace
RUN mkdir -p $ECLIPSE_WORKSPACE

WORKDIR $ECLIPSE_JDT_TARGET
COPY start.sh start.sh

CMD ["/bin/bash", "start.sh"]