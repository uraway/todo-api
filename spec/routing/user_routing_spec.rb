require 'rails_helper'

RSpec.describe 'routing to user', type: :routing do
  it 'routes /v1/signup to /v1/user#create' do
    expect(post: '/v1/signup').to route_to(
      format: :json, controller: 'v1/users', action: 'create'
    )
  end
end
