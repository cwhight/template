puts "starting seed"

require 'faker'

addresses = ["28 Balaclava Road, London Borough of Southwark, England, United Kingdom",
"93 Poole Street, London Borough of Hackney, England, United Kingdom",
"68 Abbey Drive, London Borough of Wandsworth, England, United Kingdom",
"47 Butts Piece, London Borough of Ealing, England, United Kingdom",
"99, Crawley, South East, United Kingdom",
"1-38 Ollerton Green, London Borough of Tower Hamlets, Greater London, United Kingdom",
"Barnes, London Borough of Richmond upon Thames, England, United Kingdom",
"49 Canalside Square, London Borough of Islington, England, United Kingdom",
"12 Upper Street, London Borough of Islington, England, United Kingdom",
"16 Commonside West, London Borough of Merton, England, United Kingdom",
"13 East Road, London Borough of Hackney, England, United Kingdom",
"418 Brixton Road, London Borough of Lambeth, England, United Kingdom",
"Shoreditch High Street, London Borough of Hackney, England, United Kingdom",
"London Borough of Islington, England, United Kingdom",
"Acton Town, London Borough of Ealing, Greater London, United Kingdom",
"Aston Street, London Borough of Tower Hamlets, England, United Kingdom",
"Waterloo Road, London Borough of Lambeth, England, United Kingdom",
"Balham High Road, London Borough of Wandsworth, England, United Kingdom",
"Elephant and Castle, London Borough of Southwark, England, United Kingdom",
"Shoreditch, London Borough of Hackney, England, United Kingdom"]
p addresses.size

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

employee_review_scores = [4,5,4,2]
employee_review_titles = ["Did a good job", "Was a great worker", "Would hire again", "Bad experience"]
employee_review_content = ["Very experienced, picked up tasks easily and got on well with everyone", "Nothign more to add, they were great", "Happy to hire them again, turned up on time, carried out the shift professionally", "Would not reccomend, turned up late, sloppy and inexperienced"]
employer_review_scores = [4,5,5,1]
employer_review_titles = ["Great to work for", "Busy shift, but fair employer", "Happily work for them again", "Bad experience"]
employer_review_content = ["No problems, paid on time, comfortable environment and friendly boss", "Very busy bar, but good staff and friendly boss", "Nothing to add, would happily work for them again", "Not a safe place to work, overcrowded, dirty and boss was unreasonable"]
shift_starts = [Time.now + 360, Time.now + 3600, Time.now + 3600*24 ]
past_shift_starts = [Time.now - 24*3*3600, Time.now - 8*3600, Time.now - 3600*24 ]
employers = []
employees = []

puts "creating random employers"

10.times do
  user = User.create!(dob: "01/01/1982", email: Faker::Internet.email, password: "123456", employer: true, first_name: Faker::Name.first_name, surname: Faker::Name.last_name )
  employers << user
end

puts "creating Freddie"

freddie = User.create!(dob: "01/01/1980", email: "freddie@hoxton100.com", password: "123456", employer: true, first_name: "Freddie", surname: "James")


puts "Creating employees"

5.times do
 user = User.create!(dob: "01/01/1997", email: Faker::Internet.email, password: "123456", employer: false, first_name: Faker::Name.first_name, surname: Faker::Name.last_name )
 employees << user
end

puts "creating Freddie's jobs"

  i = 0
6.times do
  puts "1"
  job = Job.create!(user: freddie, title: jobs[i][0], description: jobs[i][1], location: "100-102 Hoxton St, Hackney, London N1 6SG", summary: "Hoxton 100", sectors: Sector.where(title: jobs[i][2]) )
  puts "2"
  i += 1
  # p employees[rand(0..(employees.size - 1))]
  rand(5..10).times do
    puts "future shifts"
    start_index = rand(0..2)
    Shift.create!(title: job.title, job: job, price_cents: rand(1000..2500), start_time: shift_starts[start_index], end_time: shift_starts[start_index] + rand(4..6)*3600)
    shift = Shift.last
    Request.new(shift: shift, user: employees[rand(0..(employees.size - 1))], content: "Hi, I'd really like to work this shift, please get back to me if you have any questions").save(validate: false)
  end
  puts "creating old shifts"
  rand(4..6).times do
    start_index = rand(0..2)
    user = employees[rand(0..(employees.size - 1))]
    Shift.new(user: user, title: job.title, job: job, price_cents: rand(1000..2500), start_time: past_shift_starts[start_index], end_time: past_shift_starts[start_index] + rand(4..6)*3600, completed: true).save(validate: false)
    shift = Shift.last
    Request.new(shift: shift, user: user , content: "Hi, I'd really like to work this shift, please get back to me if you have any questions").save(validate: false)
    review_index = rand(0..3)
    Review.create!(title: employee_review_titles[review_index], score: employee_review_scores[review_index], content: employee_review_content[review_index], shift: shift, user: user)
    Review.create!(title: employer_review_titles[review_index], score: employer_review_scores[review_index], content: employer_review_content[review_index], shift: shift, user: job.user)
  end
end

puts "Employers created"


puts "Creating Charlie"

User.create!(email: "charlie.whight@gmail.com", password: "123456", employer: false, first_name: "Charlie", surname: "Whight", dob: "01/11/1993" )

charlie = User.last

employees << charlie

puts "creating random jobs"

i = 0
20.times do
  job_index = rand(0..(jobs.size-1))
  job = Job.create!(user: employers[rand(0..employers.size - 1)], title: jobs[job_index][0], location: addresses[i], description: "Cover needed for multiple shifts", sectors: Sector.where(title: jobs[job_index][2]) )
  puts "jobs created"
  i += 1
  rand(1..5).times do
    start_index = rand(0..2)
    shift = Shift.create!(title: job.title, job: job, price_cents: rand(1000..2500), start_time: shift_starts[start_index], end_time: shift_starts[start_index] + rand(4..6)*3600)
    puts "Shift created"
    Request.create!(shift: shift, user: employees[rand(0..(employees.size - 1))], content: "Hi, I'd really like to work this shift, please get back to me if you have any questions")
  end
  rand(2..4).times do
    start_index = rand(0..2)
    user = employees[rand(0..(employees.size - 1))]
    Shift.new(user: user, title: job.title, job: job, price_cents: rand(1000..2500), start_time: past_shift_starts[start_index], end_time: past_shift_starts[start_index] + rand(4..6)*3600, completed: true).save(validate: false)
    shift = Shift.last
    Request.new(shift: shift, user: user , content: "Hi, I'd really like to work this shift, please get back to me if you have any questions").save(validate: false)
    review_index = rand(0..3)
    Review.create!(title: employee_review_titles[review_index], score: employee_review_scores[review_index], content: employee_review_content[review_index], shift: shift, user: user)
    Review.create!(title: employer_review_titles[review_index], score: employer_review_scores[review_index], content: employer_review_content[review_index], shift: shift, user: job.user)
  end
end

puts "Jobs Created"


puts "finished!"
