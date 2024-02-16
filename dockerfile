ARG REPO=mcr.microsoft.com/dotnet/runtime
FROM $REPO:7.0.14-bookworm-slim-amd64


RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y unzip curl expect

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 25555

ENTRYPOINT [ "bash", "-i", "/entrypoint.sh" ]
