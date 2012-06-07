#!/bin/sh
TMP=/var/tmp/tiqav.jpg

cd `dirname $0`
bundle exec ruby bin/make_lot.rb $TMP && \
bundle exec ruby bin/upload_tumblr.rb $TMP
rm -f $TMP
