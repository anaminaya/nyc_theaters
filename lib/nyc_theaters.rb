require "nyc_theaters/version"
require 'unirest'


module NycTheaters
  class NycTheater
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

    def self.where(search_term)
     key = search_term.keys.first.to_s
     value = search_term.values.first
     theaters_array = Unirest.get("https://data.cityofnewyork.us/resource/2hzz-95k8.json?#{key}=#{value}").body
     create_theaters(theaters_array)
    end

    private_class_method :create_theaters

    def self.create_theaters(theaters_array)
      theaters_array.map { |theater| NycTheater.new(theater)}
    end
  end
end
