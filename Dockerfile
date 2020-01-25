FROM alpine:latest

# Add curl
RUN apk add --update curl

# Launch updater script
COPY duck-ddns.sh /
ENTRYPOINT ["/duck-ddns.sh"]