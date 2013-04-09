class SessionsController < ApplicationController
  skip_before_filter :require_admin, :only => [:new, :create]
  
  def new
  end
  
  def create
    # Intenta encontrar un admin por emial y autentificacion con password
    if @admin = Admin.find_by_email(params[:admin][:email]).try(:authenticate, params[:admin][:password])
	  # En caso de exito salva el ID del admin de la sesion actual
	  session[:admin_id] = @admin.id
	  # Redirecciona los posts
	  redirect_to posts_path
	else
	  # En caso de fallo renderiza al formulario login y muestra un mensaje de error
	  redirect_to new_session_path, alert: "Not recognized email or password"
	end
  end
  
  def destroy
    # Borra el ID admin desde la sesion
	session.delete(:admin_id)
	redirect_to posts_path, notice: "Have a nice day!"
  end
end
