require "csv"
require "erb"
shipment_list = []

# Organize CSV data and calculate total_revenue
CSV.foreach("./planet_express_logs.csv", headers: true) do |line|
  shipment_hash = line.to_hash
  shipment_list.push(shipment_hash)
end

puts shipment_list

puts "--------------"

amount = shipment_list.map {|cash| cash["Money"].to_i}.reduce(:+)

data_log = [
{"Pilot" => "Fry" , "Number_trips" => 0, "Bonus" => 0 },
{"Pilot" => "Amy" , "Number_trips" => 0, "Bonus" => 0 },
{"Pilot" => "Bender" , "Number_trips" => 0, "Bonus" => 0 },
{"Pilot" => "Leela" , "Number_trips" => 0, "Bonus" => 0 }
]


shipment_list.each {|driver_name|

    if driver_name["Destination"] == "Earth"
      pilot_name = "Fry"
    elsif driver_name["Destination"] == "Mars"
      pilot_name = "Amy"
    elsif driver_name["Destination"] == "Uranus"
      pilot_name = "Bender"
    else
      pilot_name = "Leela"
    end

selected_pilots = data_log.select {|traveler| traveler["Pilot"] == pilot_name }
pilot_final = selected_pilots.first


initial_bonus = driver_name ["Money"].to_i * 0.10
pilot_final["Bonus"] = pilot_final["Bonus"] + initial_bonus

pilot_final["Number_trips"] = pilot_final["Number_trips"] + 1

    }


# Put total_revenue into our .html.erb template
html_template_string = File.read("./template.html.erb")
compiled_html_string = ERB.new(html_template_string).result(binding)
File.open("./output.html", "w+") do |my_f|
  my_f.write(compiled_html_string)
  my_f.close
end
