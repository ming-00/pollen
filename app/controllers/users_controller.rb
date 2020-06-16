class UsersController < Clearance::UsersController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = user_from_params
    render template: "users/new"
  end

  def show
      @user = User.find(params[:id])
  end

  def create
    @user = user_from_params

    if @user.save
      Fluency.create(level: @user.f_temp_id, user_id: @user.id, language_id: @user.temp_id)
      flash[:success] = "Welcome to Pollen! Please add your 
        information to get started."
      sign_in @user
      #redirect_back_or url_after_create
      #above redirects to home page, modified to direct to user instead
      # redirect_to @user
      redirect_to "/profile"
    else
      #flash.now[:error] = @user.errors.full_messages[0]
      #render template: "users/new"
      #changed to below resolve issue regarding formatting
      flash[:danger] = @user.errors.full_messages[0]
      redirect_to "/sign_up"
    end
  end

  def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        User.find(params[:id]).fluencies.destroy_all
        Fluency.create(level: @user.f_temp_id, user_id: @user.id, language_id: @user.temp_id)
        flash[:success] = "Profile updated"
        #sign_in @user
        redirect_to @user
      else 
        flash[:danger] = @user.errors.full_messages[0]
        redirect_to request.referrer
      end
  end


  def edit
    @user = User.find(params[:id])
  end

  private

  def user_params
      params.require(:user).permit(
        :email, 
        :password, 
        :firstname, 
        :temp_id, 
        :f_temp_id,
        :lastname, 
      )
  end

   # Confirms a logged-in user.
   def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to "/sign_in"
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
