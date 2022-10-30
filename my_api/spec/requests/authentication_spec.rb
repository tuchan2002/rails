require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /auth' do
    let(:user) { FactoryBot.create(:user, username: 'TuChan', password: '123456') }

    it 'authenticates the client' do
      post '/api/v1/auth', params: { username: user.username, password: '123456' }

      expect(response).to have_http_status(:created)
      expect(response_body).to eq({
        'token' => 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.DiPWrOKsx3sPeVClrm_j07XNdSYHgBa3Qctosdxax3w'
      })
    end

    it 'returns error when username is missing' do
      post '/api/v1/auth', params: { password: '123456'}

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({
        'error' => 'param is missing or the value is empty: username'
      })
    end

    it 'returns error when password is missing' do
      post '/api/v1/auth', params: { username: 'TuChan'}

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({
        'error' => 'param is missing or the value is empty: password'
      })
    end

    it 'returns error when password is incorrect' do
      post '/api/v1/auth', params: { username: user.username, password: '12345678' }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end