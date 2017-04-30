require 'csv'
slcsp_rows = Array.new

CSV.foreach('slcsp.csv', headers:true) do |slcsp_row|
  rate_areas = Array.new
   CSV.foreach('zips.csv', headers:true) do |zips_row|
     if zips_row['zipcode'] == slcsp_row['zipcode']
       rate_areas << zips_row['rate_area']
     end
   end

   if rate_areas.length > 1
     rate_areas.each do |area|
       if rate_areas != nil and area != rate_areas.first
         rate_areas = nil
       end
     end
   elsif rate_areas != nil
    rate_area = rate_areas.first
   end

   rates = Array.new
   CSV.foreach('plans.csv', headers:true) do |plans_row|
     if plans_row['rate_area'] == rate_area and plans_row['metal_level'] == "Silver"
       rates << plans_row['rate']
     end
   end
  slcsp_row['rate'] = rates.sort[1]
  slcsp_rows << slcsp_row
end

puts slcsp_rows
# CSV.open('sample3.csv', 'wb') { |csv| rows_array.each{|row| csv << row}}
CSV.open('slcsp_test.csv', 'wb', :write_headers=> true, :headers => ["zipcode", "rate"]) do |file|
  slcsp_rows.each do |row|
    file << row
  end
end
