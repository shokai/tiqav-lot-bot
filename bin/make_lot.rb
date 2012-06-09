#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'tiqav'
require 'tmpdir'
require 'mini_magick'
require File.expand_path 'bootstrap', File.dirname(__FILE__)+'/../'

WIDTH = 500

if ARGV.empty?
  STDERR.puts 'filename required.'
  STDERR.puts "e.g.  ruby #{$0} image.jpg"
  exit 1
end

out = ARGV.first

a = Tiqav.random
b = Tiqav.random

Dir.mktmpdir do |dir|
  img_a = MiniMagick::Image.open a.save(File.expand_path a.filename, dir)
  img_b = MiniMagick::Image.open b.save(File.expand_path b.filename, dir)
  
  puts "#{a.permalink} : #{img_a[:width]}x#{img_a[:height]}"
  puts "#{b.permalink} : #{img_b[:width]}x#{img_b[:height]}"
  img_a.resize "#{WIDTH}x#{(img_a[:height]*WIDTH/img_a[:width]).to_i}"
  img_a.write(a_path=File.expand_path("a_resized.jpg", dir))
  img_b.resize "#{WIDTH}x#{(img_b[:height]*WIDTH/img_b[:width]).to_i}"
  img_b.write(b_path=File.expand_path("b_resized.jpg", dir))
  system "convert -append #{a_path} #{b_path} #{out}"
end

if File.exists? out
  puts "make lot => #{out}"
else
  puts "failed."
end
