class UserController < ApplicationController
  def hello
    render text: "Hello Maddybird. I love you."
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params: id)
  end
end
