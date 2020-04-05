require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)
Dotenv.load

def eurToRON(date, app_id = ENV['APP_ID'])
  result = {}
  rates_url = "https://openexchangerates.org/api/historical/#{date}.json?app_id=#{app_id}&symbols=EUR,RON"
  response = RestClient.get rates_url
  parsed_response = JSON.parse(response)
  rates = parsed_response["rates"]
  usdeur = rates["EUR"] # USD/EUR 1 USD in EUR
  usdron = rates["RON"] # USD/RON means 1 USD in RON

  #
  # Generally: <original currency>/<target currency>
  # means for 1 <original currency> in <target currency>
  #
  # EUR/RON means: 1 EUR in RON
  #
  # NOT like in physics, where:
  # <target currency>/<original currency> * <original currency value> = <targetcurrency value>
  #
  # The formula for converting from `EUR to RON` based on `usd/eur` and `usd/ron` rates.
  # ---
  #
  # Input: `usd/eur`, `usd/ron`
  # Output: `eur/ron`
  #
  #    eur/ron =
  #  = eur/ron
  #  = eur/ron * usd/usd
  #  = usd/ron * eur/usd
  #  = usd/ron / usd/eur
  #  = usdron/usdeur
  #

  eurron = usdron/usdeur

  result[:date] = date
  result[:usdron] = usdron
  result[:usdeur] = usdeur
  result[:eurron] = eurron
  result
end

# We are interested on the rate on every 1st of the month.
# months = (Date.new(2019, 01)..Date.new(2020, 03)).select {|d| d.day == 1}
months = (Date.new(2016, 01)..Date.new(2020, 04)).select {|d| d.day == 1}
dates = months.map{|date| date="#{date.year}-%02d-%02d" % [date.month, date.day]; puts date; date }
total_result = dates.reduce({}){|memo, date| memo[date] = eurToRON(date); memo}
total_with_diff = total_result.transform_values{|data|ron = 100*data[:eurron]; data.merge(diff: ron - 450, ron: ron)}

# saving:
File.open("hash.marshal", "w"){|to_file| Marshal.dump(total_with_diff, to_file)}
# retrieving:
# total_with_diff = File.open("hash.marshal", "r"){|from_file| Marshal.load(from_file)}

total_diff = total_with_diff.values.map{|data|data[:diff]}

total_with_diff.each_pair do |date, result|
  puts "100EUR converted to RON on the date of #{result[:date]}` is: %0.2fRON, the diff is: %0.2fRON" % [result[:ron], result[:diff]]
end
puts "Diff: #{total_diff.sum}"

date = "2020-04-05"
result = eurToRON(date)
