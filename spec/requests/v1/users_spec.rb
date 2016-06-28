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
    expect(body).to have_json_path 'id'
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

describe 'POST /v1/users' do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_params) { { email: user.email, password: user.password } }

  it 'create a new user' do
    post '/v1/users',
      params: { user: { email: 'xxx@exmaple.com', password: 'password' } }

    expect(response).to be_success
    expect(response.status).to eq 200
  end

  it 'fails to create a new user when email is nil' do
    post '/v1/users',
      params: { user: { email: nil, password: user.password } }

    expect(response).not_to be_success
    expect(response.status).to eq 422
    expect(parse_json(response.body)['error']).to eq 'Invalid email or password.'
  end

  it 'fails to create a new user when email is invalid' do
    post '/v1/users',
      params: { user: { email: 'invalid,,,email', password: user.password } }

    expect(response).not_to be_success
    expect(response.status).to eq 422
    expect(parse_json(response.body)['error']).to eq 'Invalid email or password.'
  end

  it 'fails to create a new user when password is nil' do
    post '/v1/users',
      params: { user: { email: user.email, password: nil } }

    expect(response).not_to be_success
    expect(response.status).to eq 422
    expect(parse_json(response.body)['error']).to eq 'Invalid email or password.'
  end

  it 'fails to create a new user when password is less than 6 charactors' do
    post '/v1/users',
      params: { user: { email: user.email, password: '1234' } }

    expect(response).not_to be_success
    expect(response.status).to eq 422
    expect(parse_json(response.body)['error']).to eq 'Invalid email or password.'
  end
end
