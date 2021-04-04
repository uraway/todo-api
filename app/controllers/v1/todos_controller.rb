module V1
  class TodosController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index, :show]

    def create
      Todo.transaction do
        @todo = Todo.new(todo_params)
        @todo.save!
      end
      render json: @todo, serializer: V1::TodoSerializer, status: :created
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end

    def update
      Todo.transaction do
        @todo = Todo.find(params[:id])
        @todo.update!(todo_params)
      end
      render json: @todo, serializer: TodoSerializer
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end

    def destroy
      Todo.transaction do
        @todo = Todo.find(params[:id])
        @todo.destroy!
      end
      render json: @todo, serializer: TodoSerializer
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end

    private

    def todo_params
      params.require(:todo).permit(:text, :completed).merge(user: current_user)
    end
  end
end
