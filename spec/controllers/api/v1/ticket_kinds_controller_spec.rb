require 'rails_helper'
require 'controllers/base'

RSpec.describe Api::V1::TicketKindsController,
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
      it 'returns all the ticket_kinds' do
        FactoryGirl.create_list(:ticket_kind, 5)
        get :index, format: :json
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.length).to eq(5)
      end
    end
  end

  describe '#show' do
    let(:ticket_kind) { FactoryGirl.create(:ticket_kind) }

    context 'when asking existing object' do
      it 'responds with 200' do
        get :show, params: { id: ticket_kind }, format: :json
        expect(response).to be_success
      end

      it 'returns data of an single ticket_kind' do
        get :show, params: { id: ticket_kind }, format: :json
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
        post :create, params: { name: 'test' }
        expect(response).to be_success
      end

      it 'responds correct json' do
        post :create, params: { name: 'correct json test' }
        expect(response).to be_success
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.keys.sort).to eq(%w(created_at id name))
      end
    end

    context 'incorrect name' do
      it 'responds with 406' do
        post :create, params: { name: '' }
        expect(response.status).to eq(406)
      end
    end
  end

  describe '#destroy' do
    let(:ticket_kind) { FactoryGirl.create(:ticket_kind) }

    context 'correct id' do
      it 'returns a successful json' do
        delete :destroy, params: { id: ticket_kind }
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
    let(:ticket_kind) { FactoryGirl.create(:ticket_kind) }

    context 'correct data' do
      it 'responds with 200' do
        put :update, params: { id: ticket_kind, name: 'new test' }
        expect(response).to be_success
      end
    end

    context 'incorrect id' do
      it 'returns an 404 error' do
        put :update, params: { id: 100_500, name: 'wrong' }
        expect(response).to be_not_found
      end
    end
  end
end
