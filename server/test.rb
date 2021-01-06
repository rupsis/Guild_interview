require './server'
require 'rspec'
require 'rack/test'
require 'date'


RSpec.describe 'Guild Messaging API tests' do
    include Rack::Test::Methods
    let(:app) { App.new }
  
    context "gets the last 100 messages from a specific user" do
        let(:response) { get "/v1/2/message?recipientId=3&limit=100" }

        it "returns status 200 OK" do
            expect(response.status).to eq 200
        end

        
        it "returns messages from user 3" do
            parsed_response = JSON.parse(response.body)
            expect(parsed_response['messages'].length).to be > 0
        end
    end

    context "gets the last all messages from the last 30 days " do
        let(:response) { get "/v1/2/message?startTime=#{DateTime.now() - 30}&endTime=#{DateTime.now()}&limit=100" }

        it "returns status 200 OK" do
            expect(response.status).to eq 200
        end

        
        it "returns messages from user 3" do
            parsed_response = JSON.parse(response.body)
            expect(parsed_response['messages'].length).to be > 0
        end
    end

    context "Creates a new message " do
        params = {
            recieverId: 3,
             message:"test",
             timestamp: "2021-01-05 22:50:03.62013"
        }
        let(:response) { post "/v1/2/message", params.to_json, { 'CONTENT_TYPE' => 'application/json'} }

        it "returns status 200 OK" do
            expect(response.status).to eq 200
        end
    end

  end