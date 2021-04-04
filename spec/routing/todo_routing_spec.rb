require 'rails_helper'

RSpec.describe 'routing to todos', type: :routing do
  it 'routes /v1/users/:user_id/todos/:id to /v1/todos#create' do
    expect(post: '/v1/users/1/todos').to route_to(
      format: :json, controller: 'v1/todos', action: 'create', user_id: '1'
    )
  end

  it 'routes /v1/users_:user_id/todos/:id to /v1/todos#update' do
    expect(put: '/v1/users/1/todos/1').to route_to(
      format: :json, controller: 'v1/todos', action: 'update', user_id: '1', id: '1'
    )
  end

  it 'routes /v1/todos/:id to /v1/todos#destroy' do
    expect(delete: '/v1/users/1/todos/1').to route_to(
      format: :json, controller: 'v1/todos', action: 'destroy', user_id: '1', id: '1'
    )
  end
end
