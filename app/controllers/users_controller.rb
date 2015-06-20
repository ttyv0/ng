class UsersController < ApplicationController
  def show
    id = params[:id]
    if id == '0' or id.to_i > 0
      @user = User.find(id.to_i)
    else
      @user = User.find_by name: id
    end
  end
end
