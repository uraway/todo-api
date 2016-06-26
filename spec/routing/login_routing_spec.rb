require 'rails_helper'

RSpec.describe 'routing to login', type: :routing do
  it 'routes /v1/login to /v1/sessions#create' do
    expect(post: '/v1/login').to route_to(
      format: :json, controller: 'v1/sessions', action: 'create'
    )
  end
end
