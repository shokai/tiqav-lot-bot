#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'tmpdir'
require 'mini_magick'
require File.expand_path 'bootstrap', File.dirname(__FILE__)+'/../'
require 'tiqav'

if ARGV.empty?
  STDERR.puts 'filename required.'
  STDERR.puts "e.g.  ruby #{$0} image.jpg"
  exit 1
end

out = ARGV.first

a = Tiqav.random
b = Tiqav.random

Dir.mktmpdir do |dir|
  a_path = a.save File.expand_path a.filename, dir
  b_path = b.save File.expand_path b.filename, dir
  img_a = MiniMagick::Image.open a_path
  img_b = MiniMagick::Image.open b_path
  
  puts "#{a.permalink} : #{img_a[:width]}x#{img_a[:height]}"
  puts "#{b.permalink} : #{img_b[:width]}x#{img_b[:height]}"
  if img_a[:width] > img_b[:width]
    img_a.resize "#{img_b[:width]}x#{(img_a[:height]*img_a[:width]/img_b[:width]).to_i}"
    a_path = File.expand_path "resized.jpg", dir
    img_a.write a_path
  elsif img_a[:width] < img_b[:width]
    img_b.resize "#{img_a[:width]}x#{(img_b[:height]*img_b[:width]/img_a[:width]).to_i}"
    b_path = File.expand_path "resized.jpg", dir
    img_b.write b_path
  end
  system "convert -append #{a_path} #{b_path} #{out}"
end

if File.exists? out
  puts "make lot => #{out}"
else
  puts "failed."
end
