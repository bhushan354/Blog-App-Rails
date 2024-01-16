require 'rails_helper'

RSpec.describe 'Users Controller specs', type: :request do
  describe 'GET /index' do
    it "Redirects ti users list pahge" do
      get '/users/:user_id/posts'
      expect(response).to render_template(:index)
      expect(response.body).to include('All the posts of individual user')
    end

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
    it 'Redirects to the user profile page' do
      get '/users/:user_id'
      expect(response).to render_template(:show)
      expect(response.body).to include('Details of particular user')
    end

    it 'will not show a different template' do
        get '/users/:user_id'
        expect(response).to_not render_template(:index)
      end

    it 'GET /users/:user_id url should return 200' do
      get '/users/:user_id'
      expect(response.status).to eq(200)
    end
  end
end