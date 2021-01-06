require 'sinatra/base'
require 'sinatra/param'
require 'json'
require 'pg'

# This normally would be a dependency injection configured using env vars
# Don't use global variables kids. 
$conn = PG.connect('localhost', '5555', nil, nil, 'guild', 'postgres', 'test')
$conn.prepare('messages', 'insert into messages (senderId, receiverId, message, "timestamp") values ($1, $2, $3, $4)')


class App < Sinatra::Base
    helpers Sinatra::Param

    before do
        content_type :json
    end

    get '/v1/:userId/message' do
        param :userId, Integer, required: true
        param :recipientId, Integer
        param :limit, Integer, required: true
        param :offset, Integer
        param :startTime, DateTime
        param :endTime, DateTime

    
    begin
        userId = params['userId']
        dateRange = params.key?('startTime') && params.key?('endTime') ? 
            "AND \"timestamp\" BETWEEN '#{params['startTime']}' AND '#{params['endTime']}'" : 
            ""
        offset = params.key?('offset') ? "OFFSET #{params['offset']}" : ""

        res = if params.key?('recipientId')
            $conn.exec "SELECT * FROM messages where 
                (senderId = #{userId} OR receiverId = #{userId})
                AND (senderId = #{params['recipientId']} OR receiverId = #{params['recipientId']}) #{dateRange} LIMIT #{params['limit']} #{offset}"
        else
            $conn.exec "SELECT * FROM messages where 
                (senderId = #{userId} OR receiverId = #{userId}) #{dateRange} LIMIT #{params['limit']} #{offset}"
        end

        messages = []

        res.each do |row|
            messages <<  {
                "messageId" => row['messageid'],
                "senderId" => row['senderid'],
                "receiverId" => row['receiverid'],
                "message" => row['message'],
                "timestamp" => row['timestamp'],
            }
        end
    
        status 200
        {
            "messages" => messages,
            "limit" => params['limit'],
            "offset" => params.fetch(:offset, 0) 
        }.to_json
    ensure
        body 'There was a problem processing your request'
    end
         
    
    end



    post '/v1/:userId/message' do
        param :userId, Integer, required: true

            senderId = params['userId']
            payload = JSON.parse(request.body.read)

            $conn.exec_prepared('messages', [ 
                senderId,
                payload['recieverId'],
                payload['message'],
                payload['timestamp']
            ])

            puts "Message from #{senderId} to #{payload['recieverId']} created"

    end
end