class TasksController < ApplicationController
  before_action :correct_user,  only: [:show, :edit, :update, :destroy]
 
  def index
    if (logged_in?)
      #@tasks = Task.all.page(params[:page]).per(5)
      @tasks = current_user.tasks.page(params[:page]).per(5)
    else
      redirect_to login_url
    end
  end
  
  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクが正常に入力されました'
      redirect_to @task
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'タスクが入力されませんでした'
      render :new
    end
  end

  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end
  
  
  private
  
  # Strong Parameter
  
  def task_params
    params.require(:task).permit(:status, :content)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
     redirect_to root_url
    end
  end
end
