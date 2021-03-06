# Used in http://sourcey.com/rails-4-omniauth-using-devise-with-twitter-facebook-and-linkedin
# This class also uses CanCan to protect user object access
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
 
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end
 
  # GET /users/1
  # GET /users/1.json
  def show
    authorize! :read, @user
  end
 
  # GET /users/1/edit
  def edit
    authorize! :manage, @user
  end
 
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    authorize! :manage, @user
    respond_to do |format|
      if @user.update(user_params) # @user.update_with_password(user_params)
        sign_in(current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
 
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    authorize! :manage, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
 
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :role)
    end
end