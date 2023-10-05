Dockerfile for building a Docker container of [eclipse/eclipse.jdt.ls](https://github.com/eclipse/eclipse.jdt.ls)

Fork of https://github.com/Kaylebor/eclipse.jdt.ls-docker

TO UPDATE
[Built images are available here](https://hub.docker.com/r/kaylebor/eclipse.jdt.ls)

Running on OpenJDK 17

Example run configuration:

        docker build -t eclipse.jdt.ls-docker .

        docker run -p 3000:3000 eclipse.jdt.ls-docker

        docker ps
