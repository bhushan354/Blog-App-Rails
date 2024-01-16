require 'rails_helper'

RSpec.describe 'testing posts controller', type: :request do
  describe 'GET /index' do
    it 'redirects to userpost page' do
      get '/users/:user_id/posts'
      expect(response).to render_template(:index)
      expect(response.body).to include('All the posts of individual user')
    end

    it 'will not show a different template' do
      get '/users/:user_id/posts'
      expect(response).not_to render_template(:show)
    end

    it 'GET users/id/posts url should return 200' do
      get '/users/:user_id/posts'
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /show' do
    it 'Redirects to each post' do
      get '/users/:user_id/posts/:id'
      expect(response).to render_template(:show)
      expect(response.body).to include('Particular single post of a user')
    end

    it 'will not show a different template' do
      get '/users/:user_id/posts/:id'
      expect(response).not_to render_template(:index)
    end

    it 'GET users/id/posts/id should return 200' do
      get '/users/:user_id/posts/:id'
      expect(response.status).to eq(200)
    end
  end
end
