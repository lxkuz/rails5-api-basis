class BaseSerializer < ActiveModel::Serializer
  attribute :created_at do
    object.created_at.to_i
  end
end
