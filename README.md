Tiqav-Lot bot
=============


Install Dependencies
--------------------

    % brew install imagemagick
    % gem install bundler
    % bundle install


Config
------

    % cp sample.config.yml config.yml

edit config.yml.


Make Lot and Upload
-------------------

    % ruby bin/make_lot.rb image.jpg
    % ruby bin/upload_tumblr.rb image.jpg
