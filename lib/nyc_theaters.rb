require "nyc_theaters/version"
require 'unirest'


module NycTheaters
  class Theater
    attr_reader :name, :url, :phone, :address, :city, :zip

    def initialize(theater)
       @name = theater['name'],
       @url = theater['url'],
       @phone = theater['tel'],
       @address = theater['address1'],
       @city = theater['city'],
       @zip = theater['zip']
    end

    def self.all
     theaters_array = Unirest.get('https://data.cityofnewyork.us/resource/2hzz-95k8.json').body
     theaters = []
     create_theaters(theaters_array)
    end

  end
end
