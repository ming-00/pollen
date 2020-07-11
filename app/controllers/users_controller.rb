class UsersController < Clearance::UsersController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = user_from_params
    render template: "users/new"
  end

  def show
      @user = User.find(params[:id])
      @journals = @user.journals.paginate(page: params[:page])
      @forumposts = @user.forumposts.paginate(page: params[:page])  
    end

  def index
    @users = User.all
  end

  def create
    @user = user_from_params

    if @user.save
      @user.fluencies.create(level: @user.f_temp_id, language_id: @user.temp_id)
      flash[:success] = "Welcome to Pollen!"
      sign_in @user
      #redirect_back_or url_after_create
      #above redirects to home page, modified to direct to user instead
      # redirect_to @user
      redirect_to "/"
    else
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
        @user.fluencies.create(level: @user.f_temp_id, language_id: @user.temp_id)
        flash[:success] = "Profile updated"
        #sign_in @user
        redirect_to '/profile'
      else 
        flash[:danger] = @user.errors.full_messages[0]
        redirect_to request.referrer
      end
  end


  def edit
    @user = User.find(params[:id])
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
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

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
