#!/bin/bash

# auto-renew SSL certificates on expire (check every 12 hrs)
trap exit TERM;
while :;
    do certbot renew;
    sleep 12h & wait ${!};
done;