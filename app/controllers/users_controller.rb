class UsersController < Clearance::UsersController
    
    def show
        @user = User.find(params[:id])
    end

    def create
        @user = user_from_params
    
        if @user.save
          sign_in @user
          redirect_back_or url_after_create
        else
          flash.now[:error] = @user.errors.full_messages[0]
          render template: "users/new"
        end
      end

    private

    def user_params
        params.require(:user).permit(
          :email, 
          :password, 
          :firstname, 
          :lastname, 
        )
    end
end
