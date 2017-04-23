require 'rails_helper'
require 'controllers/base'

RSpec.describe Api::V1::UsersController,
               type: :controller do
  include JWTAuthAdmin

  describe '#index' do
    context 'when no params' do
      it 'responds with 200' do
        get :index, format: :json
        expect(response).to be_success
      end
    end
    context 'objects was created' do
      it 'returns all the users with the current_user' do
        FactoryGirl.create_list(:user, 5)
        get :index, format: :json
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.length).to eq(6)
      end
    end
  end

  describe '#show' do
    let(:user) { FactoryGirl.create(:user) }

    context 'when asking existing object' do
      it 'responds with 200' do
        get :show, params: { id: user }, format: :json
        expect(response).to be_success
      end

      it 'returns data of an single user' do
        get :show, params: { id: user }, format: :json
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to_not be_nil
      end
    end

    context 'when asking wrong object' do
      it 'responds with 404' do
        get :show, params: { id: 100_500 }, format: :json
        expect(response).to be_not_found
      end
    end
  end

  describe '#create' do
    context 'when correct data' do
      it 'responds with 200' do
        post :create, params: FactoryGirl.build(:user).attributes
        expect(response).to be_success
      end
    end

    context 'incorrect name' do
      it 'responds with 406' do
        post :create, params: { title: '' }
        expect(response.status).to eq(406)
      end
    end
  end

  describe '#destroy' do
    let(:user) { FactoryGirl.create(:user) }

    context 'correct id' do
      it 'returns a successful json' do
        delete :destroy, params: { id: user.id }
        expect(response).to be_success
      end
    end

    context 'incorrect id' do
      it 'returns an 404 error' do
        delete :destroy, params: { id: 100_500 }
        expect(response).to be_not_found
      end
    end
  end

  describe '#update' do
    let(:user) { FactoryGirl.create(:user) }

    context 'correct data' do
      it 'responds with 200' do
        put :update, params: { id: user, title: 'new test user' }
        expect(response).to be_success
      end
    end

    context 'incorrect id' do
      it 'returns an 404 error' do
        put :update, params: { id: 100_500, title: 'wrong test user' }
        expect(response).to be_not_found
      end
    end
  end
end
