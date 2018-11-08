require 'nokogiri'
require 'rubygems'
require 'open-uri'

class Scraper

attr_accessor :price, :name

 def get_price
	  doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
    price = doc.css('a.price').map { |i| i.text } #converti les valeurs en texte
#   @crypto_price = []
#	  @crypto_price << price
end

def get_name
	  doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
    name = doc.css('a.currency-name-container').map { |i| i.text }
#   @crypto_name = []
#	  @crypto_name << name
end


def hash
    #@hash_crypto = []
    @hash_crypto = Hash[get_name.zip(get_price)]
end

def save
    Crypto.destroy_all
    @hash_crypto.each do |k, v| i = Crypto.create(name: k,price: v)
    end
  end

def perform
    puts hash
    puts save
    return @hash_crypto
end

end