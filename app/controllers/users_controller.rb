class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @posts = @user.posts
               .page(params[:page]).order(created_at: :desc)
  end

  private
    def set_user
      @user = User.find_by(username: params[:username])
    end
end
