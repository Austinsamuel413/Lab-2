require 'CSV'

require 'ERB'

# shipments.each {|data|} data{money}

shipments= []
CSV.foreach("./planet_express_logs.csv", headers: true) do |row|
  shipments << row.to_hash
end

employees = %[Fry, Amy, Bender, Leela]
planets =
bonus_multiplyer= 0.10
income = shipments.map {}




b = binding
template = File.read("./report.erb")
result = ERB.new(template).result(b)
