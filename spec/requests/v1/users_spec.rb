require 'rails_helper'

describe 'POST /v1/login' do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_params) { { email: user.email, password: user.password } }

  before do
    user
  end

  it 'logins' do
    post '/v1/login',
      params: user_params

    expect(response).to be_success
    expect(response.status).to eq 200
    body = response.body
    expect(body).to have_json_path 'email'
    expect(body).to be_json_eql(%("#{user.email}")).at_path 'email'
    expect(body).to have_json_path 'user_id'
    expect(body).to have_json_path 'token_type'
    expect(body).to have_json_path 'access_token'
  end

  it 'fails to login when email is invalid' do
    post '/v1/login',
      params: { email: user.email, password: 123 }

    expect(response).not_to be_success
    expect(response.status).to eq 422
    expect(parse_json(response.body)['error']).to eq 'Invalid email or password.'
  end

  it 'fails to login when password is invalid' do
    post '/v1/login',
      params: { email: 'wrong@example.com', password: user.password }

    expect(response).not_to be_success
    expect(response.status).to eq 422
    expect(parse_json(response.body)['error']).to eq 'Invalid email or password.'
  end
end
