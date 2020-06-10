FROM alpine:latest

# some complex container setup using custom libs
# ...
COPY ./index.html /usr/src/app/
WORKDIR /usr/src/app/

# some complex static html / js build process i.e. `npm build`
CMD ["sh", "-c", "cp index.html /usr/src/app/build"]

# run with
# $ docker build -t web-application-build .
# $ docker run --volume /where/to/output:/usr/src/app/build web-application-build
