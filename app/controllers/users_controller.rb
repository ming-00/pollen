class UsersController < Clearance::UsersController
    
    def show
        @user = User.find(params[:id])
    end

    def create
        @user = user_from_params
    
        if @user.save
          flash[:success] = "Welcome to Pollen! Please edit your 
            information to get started."
          sign_in @user
          #redirect_back_or url_after_create
          #above redirects to home page, modified to direct to user instead
          redirect_to @user
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
        if @user.update_attributes(params[:current_user])
          flash[:success] = "Profile updated"
          redirect_to @user
        else 
          render 'edit'
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
          :lastname, 
        )
    end



end
