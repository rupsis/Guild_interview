require 'faker'
require 'pg'


conn = PG.connect('localhost', '5555', nil, nil, 'guild', 'postgres', 'test')


conn.prepare('users', 'insert into "user" (firstName, lastName) values ($1, $2)')
conn.prepare('messages', 'insert into messages (senderId, receiverId, message, "timestamp") values ($1, $2, $3, $4)')

# Create 100 users
(0..100).step(1) do |n|
    conn.exec_prepared('users', [ Faker::Name.first_name, Faker::Name.last_name ])
end


# Create 10,000 messages
(0..10000).step(1) do |n|
    conn.exec_prepared('messages', [ 
        Faker::Number.between(from: 1, to: 100),
        Faker::Number.between(from: 1, to: 100),
        Faker::Lorem.paragraph,
        Faker::Time.between(from: DateTime.now - 100, to: DateTime.now)
    ])
end






puts "db seeding completed";