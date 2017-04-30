require 'csv'

CSV.foreach('slcsp.csv', headers:true) do |slcsp_row|
  #  zones = Array.new
  #  puts slcsp_row['zipcode']
  rate_areas = Array.new
   CSV.foreach('zips.csv', headers:true) do |zips_row|
    #  puts zips_row['zipcode']
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
   puts rate_area


  #  CSV.foreach('plans.csv', headers:true) do |plans_row|
end

#
# CSV.open('slcsp_test.csv', 'w') do |file|
#   CSV.foreach(file, headers:true) do |row|
#     puts row.inspect
#   end
# end
