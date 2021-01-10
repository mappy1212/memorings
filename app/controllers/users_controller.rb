class UsersController < ApplicationController
  
  def show
    user = User.find(params[:id])
    @name = user.name
    @id = user.id
    @image = user.image
    @occupation = user.occupation
    @profile = user.profile
    @tweets = user.tweets.order("created_at DESC")
  end
  
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :nickname, :occupation, :profile, :email)
  end
end
