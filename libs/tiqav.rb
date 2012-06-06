require File.expand_path 'alpha_num', File.dirname(__FILE__)
require 'net/http'
require 'uri'

class Tiqav
  class Error < StandardError
  end

  class Image
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def permalink
      "http://tiqav.com/#{@id}"
    end

    def filename
      "#{@id}.jpg"
    end

    def url
      "http://tiqav.com/#{filename}"
    end

    def save(fname)
      uri = URI.parse url
      res = Net::HTTP.start(uri.host, uri.port).
        request(Net::HTTP::Get.new uri.path)
      unless res.code.to_i == 200          
        raise Error, "HTTP Status #{res.code} - #{url}"
      end
      open(fname,'w+') do |f|
        f.write res.body
      end
      fname
    end

    def exists?
      uri = URI.parse url
      case code = Net::HTTP.start(uri.host, uri.port).
          request(Net::HTTP::Head.new uri.path).
          code.to_i
        when 200
        return true
        when 404
        return false
      end
      raise Error, "HTTP Status #{code} - Bad Response from #{url}"
    end
  end

  def self.random
    loop do
      res = Image.new AlphaNum.encode rand 10000
      return res if res.exists?
      sleep 1
    end
  end
end

if __FILE__ == $0
  img = Tiqav::Image.new 'ae'
  puts img.exists?
  puts img.url

  img = Tiqav.random
  puts img.id
  puts img.permalink
  puts img.url
  img.save img.filename
end
