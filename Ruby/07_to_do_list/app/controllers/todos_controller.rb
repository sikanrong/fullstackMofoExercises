class TodosController < ApplicationController

  before_action :require_user

  def index
    @todos = Todo.where({:user_id=>@current_user.id})
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.user_id = @current_user.id
    @todo.save!

    redirect_to '/'
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update_attributes(todo_params)
      redirect_to(:action => 'index')
    else
      render 'edit'
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect_to '/'
  end

  private
  def todo_params
    params.require(:todo).permit(:content)
  end
end
