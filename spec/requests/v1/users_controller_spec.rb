require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  include Docs::V1::UsersDescriptor::Api

  describe 'routes' do
    it { should route(:get, 'v1/users').to(action: :index) }
    it { should route(:post, 'v1/users/sign_in').to(action: :sign_in) }
    it { should route(:post, 'v1/users/register').to(action: :register) }
    it { should route(:put, 'v1/users').to(action: :update) }
    it { should route(:delete, 'v1/users').to(action: :destroy) }
  end

  describe 'sign_in' do
    include Docs::V1::UsersDescriptor::SignIn
    it 'signs in successfully', :dox do
      user = create(:user)
      params = {username: user.username, password: user.password}
      post :sign_in, params: params
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['user']['auth_token'].blank?).to eq(false)
    end

    it 'fails to sign in successfully if the password is incorrect' do
      user = create(:user)
      params = {username: user.username, password: '123'}
      post :sign_in, params: params
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'register' do
    include Docs::V1::UsersDescriptor::Register
    it 'registers successfully', :dox do
      params = {user: attributes_for(:user)}
      post :register, params: params
      expect(response).to have_http_status(:created)
      json_response = JSON.parse(response.body)
      expect(json_response['user']['auth_token'].blank?).to eq(false)
    end

    it 'fails to register if the passwords do not match' do
      params = {user: attributes_for(:user)}
      params[:user][:password] = '123'
      post :register, params: params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'index' do
    include Docs::V1::UsersDescriptor::Index
    it 'gets all users', :dox do
      create_list(:user, 2)
      params = {}
      get :index, params: params
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['users'].length).not_to eq(0)
    end

    it 'gets a user with a certain username', :dox do
      create_list(:user, 2)
      params = { username: User.last.username }
      get :index, params: params
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['users'][0]['username']).to eq(User.last.username)
    end
  end

  describe 'update' do
    include Docs::V1::UsersDescriptor::Update
    it 'updates the user successfully', :dox do
      user = create(:user)
      params = {user: { mobile_token: '123', password: '123', password_confirmation: '123' }}
      request.headers['Authorization'] = AuthenticateUser.call(user.username, user.password).result
      put :update, params: params
      expect(response).to have_http_status(:ok)
      user.reload
      json_response = JSON.parse(response.body)
      expect(json_response['user']['mobile_token']).to eq('123')
      expect(user.authenticate('123')).to eq(user)
    end

    it 'fails to update the user if not authenticated' do
      user = create(:user)
      params = {user: { mobile_token: '123', password: '123', password_confirmation: '123' }}
      put :update, params: params
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'destroy' do
    include Docs::V1::UsersDescriptor::Destroy
    it 'deletes the user successfully', :dox do
      user = create(:user)
      params = {}
      request.headers['Authorization'] = AuthenticateUser.call(user.username, user.password).result
      delete :destroy, params: params
      expect(response).to have_http_status(:no_content)
      expect(response.body).to eq('{}')
    end

    it 'fails to delete the user if not authenticated' do
      user = create(:user)
      params = {}
      delete :destroy, params: params
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
