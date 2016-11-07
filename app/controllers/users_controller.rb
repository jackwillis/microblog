class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @posts = @user.posts.limit(10)
  end

  private
    def set_user
      @user = User.find_by(username: params[:username])
    end
end
