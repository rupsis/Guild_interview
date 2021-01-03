require 'faker'
require 'pg'


conn = PG.connect('localhost', '5555', nil, nil, 'guild', 'postgres', 'test')



# Create 100 users




# Create a 100,000 messages to random users




puts "db seeding completed";