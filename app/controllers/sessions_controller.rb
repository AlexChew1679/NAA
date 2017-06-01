class SessionsController < ApplicationController

  def new
  end

  def create
    if params[:session].present?
      # Login normal
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        remember user
        redirect_to user
        flash[:primary] = "You're now logged in"
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end  
    else      
      # Login Facebook      
      begin
        user = User.from_omniauth(request.env['omniauth.auth'])
        if user
          log_in user          
          remember user
          session[:user_id] = user.id
          redirect_to user
          flash[:primary] = "You're now logged in"
        else
          flash.now[:danger] = 'Invalid email/password combination'
          render 'new'
        end
      rescue
        flash[:warning] = "There was an error while trying to authenticate you..."
      end
     
    end
  end

  def destroy
    log_out if logged_in?
    #flash[:primary]  = 'Bye!'
    session[:user_id] = nil
    redirect_to root_path
  end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end
end
