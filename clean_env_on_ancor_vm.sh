#!/bin/sh
sudo find /var/lib/puppet/ssl/ca/signed -type f ! -iname 'puppet.pem' -delete
sudo ls /var/lib/puppet/ssl/ca/signed/
mongo ancor_development --eval 'db.dropDatabase();'

