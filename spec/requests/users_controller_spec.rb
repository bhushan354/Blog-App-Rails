require 'rails_helper'

RSpec.describe 'Users Controller specs', type: :request do
  describe 'GET /index' do
    it 'will not show a different template' do
      get '/users'
      expect(response).to_not render_template(:show)
    end

    it 'GET /users should return 200' do
      get '/users'
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /show' do
    it 'will not show a different template' do
      get '/users/:user_id'
      expect(response).to_not render_template(:index)
    end
  end
end
