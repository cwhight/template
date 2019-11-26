puts "starting seed"
sectors = ["Other", "Finance", "Business", "Charity", "Design", "Manufacturing",
              "Agriculture", "Healthcare", "Hospitality", "IT", "Security", "Leisure", "Marketing",
              "Media", "Construction", "Administration", "Retail", "Sales", "Care", "Teaching", "Transport"]

sectors.each do |e|
  puts "seeding with #{e}"
  Sector.create!(title: e)
end

puts "finished!"
