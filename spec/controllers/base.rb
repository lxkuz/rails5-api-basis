module JWTAuthAdmin
  def self.included(base)
    base.instance_eval do
      before(:each) do
        @current_user = FactoryGirl.create :user, :admin
        token = JsonWebToken.encode(@current_user.attributes.slice('id', 'email'))
        @request.headers['Authorization'] = "Bearer #{token}"
      end
    end
  end
end
