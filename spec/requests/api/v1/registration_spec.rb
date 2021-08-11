require 'rails_helper'

RSpec.describe 'Registration' do
  describe 'POST /users' do
    it 'creates a user in the database and generates a unique API key for that user' do
      post '/api/v1/users', params: {
        'Content-Type' => 'application/json', 
        'Accept' => 'application/json',
        email: "whatever@example.com",
        password: "test_password",
        password_confirmation: "test_password"
      }

      expect(response).to have_http_status 201

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to be_a Hash

      expect(response_body[:data]).to be_a Hash
      expect(response_body[:data][:type]).to eq "users"
      expect(response_body[:data][:id]).to be_a String

      attributes = response_body[:data][:attributes]
      expect(attributes).to be_a Hash
      expect(attributes[:email]).to eq "whatever@example.com"
      expect(attributes[:api_key]).to be_a String

      expect(attributes).not_to have_key :password
      expect(attributes).not_to have_key :password_confirmation
      expect(attributes).not_to have_key :password_digest
      expect(attributes.values).not_to include('test_password')
    end

    it 'returns an error message and 422 status if email has already been taken' do
      post '/api/v1/users', params: {
        'Content-Type' => 'application/json', 
        'Accept' => 'application/json',
        email: "whatever@example.com",
        password: "test_password",
        password_confirmation: "test_password"
      }

      expect(response).to have_http_status 201

      post '/api/v1/users', params: {
        'Content-Type' => 'application/json', 
        'Accept' => 'application/json',
        email: "whatever@example.com",
        password: "test_password",
        password_confirmation: "test_password"
      }

      expect(response).to have_http_status 422

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:errors]).to match(/Email has already been taken/)
    end

    it 'returns an error message and 422 status if password does not match confirmation' do
      post '/api/v1/users', params: {
        'Content-Type' => 'application/json', 
        'Accept' => 'application/json',
        email: "whatever@example.com",
        password: "test_password",
        password_confirmation: "not_my_test_password"
      }

      expect(response).to have_http_status 422

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:errors]).to match(/Password confirmation doesn't match Password/)
    end

    it 'returns an error message and 400 status if a field is missing' do
      post '/api/v1/users', params: {
        'Content-Type' => 'application/json', 
        'Accept' => 'application/json',
        email: "whatever@example.com",
        password: "test_password"
      }

      expect(response).to have_http_status 422

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:errors]).to match(/Password confirmation doesn't match Password/)
    end
  end
end