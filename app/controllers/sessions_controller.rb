class SessionsController < ApplicationController

  def new
    if current_user
      redirect_to '/club', notice: "Vous êtes déjà connecté(e)!"
    end
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Connexion réussie !"
      redirect_to '/club'
    else
      flash[:alert] = "L'email ou le mot de passe est incorrect."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Déconnexion réussie !"
  end

end
