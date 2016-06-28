require 'rails_helper'

RSpec.describe 'routing to users', type: :routing do
  it 'routes /v1/users to /v1/users#create' do
    expect(post: '/v1/users').to route_to(
      format: :json, controller: 'v1/users', action: 'create'
    )
  end
end
