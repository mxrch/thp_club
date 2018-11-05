class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if current_user
      @users = User.all
    else
      flash[:alert] = "Vous n'êtes pas connecté(e)"
      redirect_to '/login'
    end
  end

  def show
    unless current_user && @user.id == current_user.id
      render :file => "#{Rails.root}/public/403.html"
    end
  end

  def new
    if current_user
      redirect_to '/club', notice: "Vous êtes déjà connecté(e)!"
    else
      @user = User.new
    end
  end

  def edit
    unless current_user && @user.id == current_user.id
      render :file => "#{Rails.root}/public/403.html"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:alert] = nil
      redirect_to '/club', notice: "Inscription réussie !"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to '/club'
    else
      render :edit
    end
  end

  def destroy
    if current_user && @user.id == current_user.id
      @user.destroy
      session[:user_id] = nil
      redirect_to root_url, notice: "Compte supprimé !"
    else
      render :file => "#{Rails.root}/public/403.html", layout: false, status: :not_found
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
