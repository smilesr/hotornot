class UserController < ApplicationController
  def hello
    render text: "I love you Maddybird."
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params: id)
  end
end
