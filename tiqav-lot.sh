#!/bin/sh
TMP=/var/tmp/tiqav.jpg
BIN_PATH=`dirname $0`/bin
ruby $BIN_PATH/make_lot.rb $TMP && \
ruby $BIN_PATH/upload_tumblr.rb $TMP
rm -f $TMP
