puts "starting seed"

require 'faker'

jobs = [["Bar Staff","Experienced bar staf required to cover shifts at lively bar/restaurant in Hoxton","Hospitality"],
["Bar Man","Bar man wanted who has experience mixing cocktails and wokring very busy bars","Hospitality"],
 ["Waitress","Waitress needed to wait tables, lunch and dinner shifts available","Hospitality"],
  ["Waiter/Waitress","Waiter/Waitress needed to wait tables, lunch and dinner shifts available","Hospitality"],
   ["Waiter","Waiter/Waitress needed to wait tables, lunch and dinner shifts available","Hospitality"],
    ["Bar Manager","Desperately need experienced bar manager cover, our usual manager is off sick and we need someone who can run the show","Hospitality"],
     ["Cleaner","","Hospitality"],
     ["Model","","Media"],
     ["Chef","","Hospitality"],
     ["Kitchen Staff","","Hospitality"],
     ["Front of House","","Hospitality"]]

sectors = ["Other", "Finance", "Business", "Charity", "Design", "Manufacturing",
              "Agriculture", "Healthcare", "Hospitality", "IT", "Security", "Leisure", "Marketing",
              "Media", "Construction", "Administration", "Retail", "Sales", "Care", "Teaching", "Transport"].sort

sectors.each do |e|
  puts "seeding with #{e}"
  Sector.create!(title: e)
end

shift_starts = [DateTime.now + 60000, DateTime.now + 3600000, DateTime.now + 3600000*24 ]
employers = []
employees = []

puts "creating random employers"

10.times do
  user = User.create!(email: Faker::Internet.email, password: "123456", employer: true, first_name: Faker::Name.first_name, surname: Faker::Name.last_name )
  employers << user
end

puts "creating Freddie"

freddie = User.create!(dob: "01/01/2020", email: "freddie@hoxton100.com", password: "123456", employer: true, first_name: "Freddie", surname: "James")

puts "creating Freddie's jobs"

6.times do
  i = 0
  job = Job.create!(user: freddie, title: jobs[i][0], description: jobs[i][1], location: "100-102 Hoxton St, Hackney, London N1 6SG", summary: "Hoxton 100", sectors: Sector.where(title: jobs[i][2]) )
  i += 1
  10.times do
    start_index = rand(0..2)
    Shift.create!(title: job.title, job: job, price_cents: rand(1000..2500), start_time: shift_starts[start_index], end_time: shift_starts[start_index] + rand(4..6)*3600000)
  end
end

puts "Employers created"

puts "Creating employees"

5.times do
 user = User.create!(email: Faker::Internet.email, password: "123456", employer: false, first_name: Faker::Name.first_name, surname: Faker::Name.last_name )
 employees << user
end

puts "Creating Charlie"

charlie = User.create!(email: "charlie.whight@gmail.com", password: "123456", employer: false, first_name: "Charlie", surname: "Whight", dob: "01/11/1993" )

puts "creating random jobs"

100.times do
  job_index = rand(0..(jobs.size-1))
  job = Job.create!(user: User.find(rand(1..10)), title: jobs[job_index][0], location: Faker::Address.full_address, description: "Cover needed for multiple shifts", sectors: Sector.where(title: jobs[job_index][2]) )
  puts "jobs created"
  rand(1..5).times do
    start_index = rand(0..2)
    shift = Shift.create!(title: job.title, job: job, price_cents: rand(1000..2500), start_time: shift_starts[start_index], end_time: shift_starts[start_index] + rand(4..6)*3600000 )
    puts "Shift created"
    Request.create!(shift: shift, user: employees[rand(0..(employees.size - 1))], content: "Hi, I'd really like to work this shift, please get back to me if you have any questions")
  end
end

puts "Jobs Created"


puts "finished!"
