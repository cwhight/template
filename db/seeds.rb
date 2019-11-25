puts "starting seed"
sectors = ["other", "finance", "business", "charity", "design", "manufacturing",
              "agriculture", "healthcare", "hospitality", "IT", "security", "leisure", "marketing",
              "media", "construction", "administration", "retail", "sales", "care", "teaching", "transport"]

sectors.each do |e|
  puts "seeding with #{e}"
  Sector.create!(title: e)
end

puts "finished!"
