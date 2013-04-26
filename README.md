gecko
=====
To configure your servers create a file called lib/data_server_conf.rb with content like the following:

require './data_server'

module DataServerConf
  GRAPHITE = DataServer.new(:scheme => 'http', :host => 'localhost',
                        :port => 8888, :path => '/graphite',
                        :user => 'user:pass')
end
