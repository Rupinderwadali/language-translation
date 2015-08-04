class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :set_user, only: [:edit, :show, :destroy, :update]

  def index
    if params[:q].blank?
      @users = User.accessible_by(current_ability).page(params[:page]).per(20)
    else
      @users = User.accessible_by(current_ability).user_search(params[:q]).page(params[:page]).per(20)
    end

    @pagination = { current_page: @users.current_page, total_pages: @users.total_pages }
  end

  def new
   @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
         @user.invite!(current_user) if params[:user][:accepte_invitation] == "0"
         
        format.html { redirect_to users_path }
      else
        format.html { render 'new' }
      end
    end
  end

  def edit
  end

  def destroy
   @user.destroy

   redirect_to users_path
  end

  def show
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  #Called from Users Index: app/assets/javascripts/components/users/index.js.jsx.coffee
  def approve_user
    @user = User.find(params[:user_id])
    @user.login_approval_at = Time.now
    respond_to do |format|
      if @user.save
        format.json { render json: User.accessible_by(current_ability), status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  def disapprove_user
    @user = User.find(params[:user_id])
    @user.login_approval_at = nil
    respond_to do |format|
      if @user.save
        format.json { render json: User.accessible_by(current_ability), status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  #Called from Users Show: app/assets/javascripts/components/users/show.js.jsx.coffee
  def grant_admin
    @user = User.find(params[:user_id])
    @user.add_role :admin
    respond_to do |format|
      if @user.save
        format.json { render json: @user.roles.map{|a| a.name}, status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def revoke_admin
    @user = User.find(params[:user_id])
    @user.remove_role :admin
    respond_to do |format|
      if @user.save
        format.json { render json: @user.roles.map{|a| a.name}, status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
 
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :location, :lang, :contact, :gender, :organization_id, :accepte_invitation,:password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
