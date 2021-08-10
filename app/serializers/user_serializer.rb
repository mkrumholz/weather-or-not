class UserSerializer
  include JSONAPI::Serializer
  attributes :email 

  attribute :api_key do |user|
    user.api_key.token
  end

  set_type :users
end
