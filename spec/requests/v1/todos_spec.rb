require 'rails_helper'

describe 'POST /v1/users/:id/todos' do
  let(:user) { FactoryGirl.create(:user) }
  let(:todo) { FactoryGirl.create(:todo) }

  before do
    user
    todo
  end

  it 'create a new todo' do
    post "/v1/users/#{user.id}/todos",
      params: {
        todo: {
          text: 'Second Item'
        }
      },
      headers: {
        'Authorization' => user.access_token
      }
    expect(response).to be_success
    expect(response.status).to eq 201
    body = response.body
    expect(body).to have_json_path 'id'
    expect(body).to have_json_path 'user_id'
    expect(body).to be_json_eql(user.id).at_path 'user_id'

    expect(body).to have_json_path 'text'
    expect(body).to be_json_eql(%("Second Item")).at_path 'text'

    expect(body).to have_json_path 'completed'
    expect(body).to be_json_eql(false).at_path 'completed'
  end

  it 'fails to create a new todo when text is nil' do
    post "/v1/users/#{user.id}/todos",
      params: {
        todo: {
          text: nil
        }
      },
      headers: {
        'Authorization' => user.access_token
      }
    expect(response).not_to be_success
    expect(response.status).to eq 422
    expect(parse_json(response.body)['error']).to eq 'Validation failed: Text can\'t be blank'
  end
end

describe 'PUT /v1/users/:id/todos/:id' do
  let(:user) { FactoryGirl.create(:user) }
  let(:todo) { FactoryGirl.create(:todo) }

  before do
    user
    todo
  end

  it 'updates a todo' do
    put "/v1/users/#{user.id}/todos/#{todo.id}",
      params: {
        id: todo.id,
        todo: {
          text: 'Updated text',
          completed: true
        }
      },
      headers: {
        'Authorization' => user.access_token
      }
    expect(response).to be_success
    expect(response.status).to eq 200
    body = response.body

    expect(body).to have_json_path 'id'
    expect(body).to be_json_eql(todo.id).at_path 'id'

    expect(body).to have_json_path 'text'
    expect(body).to be_json_eql(%("Updated text")).at_path 'text'

    expect(body).to have_json_path 'completed'
    expect(body).to be_json_eql(true).at_path 'completed'

    expect(body).to have_json_path 'user_id'
    expect(body).to be_json_eql(user.id).at_path 'user_id'
  end

  it 'fails to update a todo when text is nil' do
    put "/v1/users/#{user.id}/todos/#{todo.id}",
      params: {
        id: todo.id,
        todo: {
          text: nil,
          completed: true
        }
      },
      headers: {
        'Authorization' => user.access_token
      }
    expect(response).not_to be_success
    expect(response.status).to eq 422
    expect(parse_json(response.body)['error']).to eq 'Validation failed: Text can\'t be blank'
  end
end

describe 'DELETE /v1/users/:id/todos/:id' do
  let(:user) { FactoryGirl.create(:user) }
  let(:todo) { FactoryGirl.create(:todo) }

  before do
    user
    todo
  end

  it 'delete a todo' do
    delete "/v1/users/#{user.id}/todos/#{todo.id}",
      params: {
        id: 1,
      },
      headers: {
        'Authorization' => user.access_token
      }
    expect(response).to be_success
    expect(response.status).to eq 200
    body = response.body
    ppp body
    expect(body).to have_json_path 'id'
    expect(body).to be_json_eql(todo.id).at_path 'id'

    expect(body).to have_json_path 'user_id'
    expect(body).to be_json_eql(todo.user_id).at_path 'user_id'

    expect(body).to have_json_path 'text'
    expect(body).to be_json_eql(%("#{todo.text}")).at_path 'text'

    expect(body).to have_json_path 'completed'
    expect(body).to be_json_eql(todo.completed).at_path 'completed'
  end
end
