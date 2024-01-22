require 'rails_helper'

RSpec.describe 'testing posts controller', type: :request do
  describe 'GET /index' do
    it 'will not show a different template' do
      get '/users/:user_id/posts'
      expect(response).not_to render_template(:show)
    end
  end

  describe 'GET /show' do
    it 'will not show a different template' do
      get '/users/:user_id/posts/:id'
      expect(response).not_to render_template(:index)
    end
  end
end
