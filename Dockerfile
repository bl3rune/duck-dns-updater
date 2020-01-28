FROM alpine:latest

# Add curl
RUN apk add --update curl

# Launch updater script
COPY duck-ddns.sh /
RUN ["chmod", "+x", "/duck-ddns.sh"]
ENTRYPOINT ["sh","/duck-ddns.sh"]