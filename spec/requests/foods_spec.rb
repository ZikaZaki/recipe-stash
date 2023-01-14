require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  describe 'GET /index' do
    before(:example) { get '/foods/index' }
    it 'redirects' do
      expect(response).to have_http_status(:found)
    end
  end

  describe 'GET /new' do
    before(:example) { get '/foods/new' }
    it 'redirects' do
      expect(response).to have_http_status(:found)
    end
  end
end
