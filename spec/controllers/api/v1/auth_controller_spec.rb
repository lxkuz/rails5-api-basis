require 'rails_helper'
require 'controllers/base'

RSpec.describe Api::V1::AuthController,
               type: :controller do
  describe '#auth' do
    let(:password) { '123qwe!' }
    let(:email) { 'test@admin.com' }

    context 'when correct params' do
      it 'responds with 200' do
        FactoryGirl.create :user, :admin,
                           email: email, password: password

        post :authenticate_user, params: { email: email, password: password }, format: :json
        expect(response).to be_success
      end

      it 'responds correct JWT token' do
        admin = FactoryGirl.create :user, :admin,
                                   email: email, password: password

        post :authenticate_user,
             params: {
               email: email,
               password: password
             }, format: :json
        parsed_response = JSON.parse(response.body)
        token = JsonWebToken.encode(
          admin.attributes.slice('id', 'email')
        )
        expect(parsed_response['auth_token']).to eq(token)
      end
    end
    context 'when incorrect password' do
      it 'responds with 200' do
        FactoryGirl.create :user, :admin,
                           email: email, password: password

        post :authenticate_user, params: { email: email, password: 'wrongpswrd' }, format: :json
        expect(response).to be_unauthorized
      end
    end
  end
end
