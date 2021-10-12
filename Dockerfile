FROM ubuntu:latest

# WORKDIR /app
COPY ./write-file.sh /
RUN chmod +x /write-file.sh

# CMD ["/usr/bin/echo hello > /mounted/foo.txt"]
ENTRYPOINT ["/bin/bash", "/write-file.sh"]
