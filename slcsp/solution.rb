require 'csv'

puts "Processing file..."

slcsp_rows = Array.new
# Find slcsps
CSV.foreach('slcsp.csv', headers:true) do |slcsp_row|
  potential_rate_areas = Array.new
  rate_area = nil

   CSV.foreach('zips.csv', headers:true) do |zips_row|
     if zips_row['zipcode'] == slcsp_row['zipcode']
       potential_rate_areas << zips_row['rate_area']
     end
   end

   if potential_rate_areas.length > 1
     potential_rate_areas.each do |area|
       if potential_rate_areas != nil and area != potential_rate_areas.first
         potential_rate_areas = nil
       end
     end
   elsif potential_rate_areas != nil and potential_rate_areas.length == 1
    rate_area = potential_rate_areas.first
   end

   rates = Array.new
   CSV.foreach('plans.csv', headers:true) do |plans_row|
     if plans_row['rate_area'] == rate_area and plans_row['metal_level'] == "Silver"
       rates << plans_row['rate']
     end
   end

  slcsp_row['rate'] = rates.sort.uniq[1] if rates.uniq.length > 1
  slcsp_rows << slcsp_row
end
# Build file
CSV.open('slcsp_solution.csv', 'wb', :write_headers=> true, :headers => ["zipcode", "rate"]) do |file|
  slcsp_rows.each do |row|
    file << row
  end
end
puts "Processing complete!"
