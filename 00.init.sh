#!/bin/bash

# Setup defaults para postfix (headless install)
debconf-set-selections <<< "postfix postfix/mailname string your.hostname.com"
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"

apt-get --assume-yes install zip unzip mailutils
