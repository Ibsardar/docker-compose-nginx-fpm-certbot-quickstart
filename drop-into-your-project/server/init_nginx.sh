#!/bin/bash

# reload nginx every 6 hours, otherwise run nginx in the foreground normally
while :
    do sleep 6h & wait ${!}
    nginx -s reload
done & nginx -g "daemon off;"