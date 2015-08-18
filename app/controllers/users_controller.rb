class UsersController < ApplicationController
  unit_action :user_deletion, :destroy 
  unit_action :user_recover, :recover

  def index
    invoke(:user_deletion, :index) do
      @users = User.all
    end
  end
end
