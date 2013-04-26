require 'rubygems'
require 'sinatra'
require 'json'
require './lib/data_server'
require './lib/data_server_conf'
require "./lib/graphite"

# Create an instance of our helper class
q = Graphite.new DataServerConf::GRAPHITE

# ============= CUSTOMIZED WIDGETS =================

# Choose your Graphite data stream. This one is for 'Idle'.

# name of the graphite data you want to stream into Geckoboard
graphite_test_target = 'graphite.com.crowdcompass.vagrant.graphite.cpu.0.idle'

# the amount of time you want displayed (-1min = the last 1 minutes)
parsedIdle = q.query(graphite_test_target, "-1min")

# target the first piece of data in the first couplet-array
dataset = parsedIdle[:datapoints].first.first
# puts dataset

# 1) Copied and pasted from Geckoboard docs. 2) Replaced ":" with "=>". 3) Replaced target value with the variable 'dataset'. 4) Other values are set to what you think is important.

# You can find the specs for other widgets in the docs at: http://docs.geckoboard.com/custom-widgets/

# this is the data structure required by "geckometer" widget
geckoboard = { "item" => dataset,
  "max" => { "text" => "Max value",
      "value" => "100"
    },
  "min" => { "text" => "Min value",
      "value" => "0"
    }
}

# this is the data structure for RAG numbers and columns
column = { "item" => [
      {
         "value" => dataset,
         "text" => "Red description"
      },
      {
         "value" => 20,
         "text" => "Amber description"
      },
      {
         "value" => 0,
         "text" => "Green description"
      }
    ]
  }

togecko = geckoboard.to_json
togeckocolumn = column.to_json

# puts dataset
# puts geckoboard
# puts togecko
# puts togeckocolumn


get "/" do
  togecko
end

get "/geckocolumn" do
  togeckocolumn
end
