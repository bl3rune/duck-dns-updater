#!/bin/sh
INTERVAL=${INTERVAL:-1800}

if [ -z "$DOMAIN" ]; then
	echo '$DOMAIN missing'
	exit 1
fi

if [ -z "$TOKEN" ]; then
	echo '$TOKEN missing'
	exit 1
fi

while true; do
	URL="https://www.duckdns.org/update?domains=${DOMAIN}&token=${TOKEN}"

	if [ -z "$MANUAL_IP"]; then
		echo "MANUAL IP: $MANUAL_IP"
		URL="${URL}&ip=${MANUAL_IP}"
	else
		PUBLIC_IP=$(curl ifconfig.me')
		if [ -z "$PUBLIC_IP" ]; then
			echo "Network error - Failed to find public IP address. Trying alternate."
			PUBLIC_IP=$(curl http://checkip.amazonaws.com)

			if [ -z "$PUBLIC_IP" ]; then
				echo "Final network error - Failed to find public IP address again"
				exit 1
			fi

		fi

		echo "IP: $PUBLIC_IP="
		URL="${URL}&ip=${PUBLIC_IP=}"
	fi

	echo "Calling URL: $URL"
	RESPONSE=$(curl -s -k "$URL" & wait)
	echo "Duck DNS response: ${RESPONSE}"

	# Sleep and loop
	sleep $INTERVAL & wait
done