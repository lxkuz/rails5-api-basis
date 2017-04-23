class UserSerializer < BaseSerializer
  attributes :id, :email, :role

  attribute :name do
    object.email
  end
end
