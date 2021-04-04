module V1
  class TodoSerializer < ActiveModel::Serializer

    attributes :id, :user_id, :text, :completed

  end
end
