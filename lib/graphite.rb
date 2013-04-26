require 'JSON'
require 'rest-client'
require 'date'
require 'URI'

class Graphite
  # Pass in the url to where your graphite instance is hosted
  def initialize(url)
    @url = url
    return url
  end

  # This is the raw query method, it will fetch the JSON from the
  # Graphite and parse it
  def query(name, since=nil)
    since ||= '-30min'
    @url.query = URI.encode_www_form(:format => 'json',
                                     :target => name,
                                     :from   => since)
    response = RestClient.get @url.to_s
    result = JSON.parse(response.body, :symbolize_names => true)
    return result.first
  end


end
