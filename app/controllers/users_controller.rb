class UsersController < ApplicationController


before_action :logged_in_user, only: [:edit, :update]

          def index
            #Show all list users
            @user = User.all
            if params[:search]
              @user = User.search(params[:search]).order("created_at DESC")
            else
              @user = User.all.order('created_at DESC')
            end
          end

          def show
            @user = User.find(params[:id])
          end

          def new
            @user = User.new
          end

          def create
            @user = User.new(user_params)
            if @user.save

            log_in @user
              flash[:success] = 'User created successfully'
              redirect_to @user
            else
              render 'new'
          end
        end

        def edit
          @user = User.find(params[:id])
        end

        def update
          @user = User.find(params[:id])
          if @user.update_attributes(user_params)
            flash[:success] = 'User updated successfully'
            redirect_to @user
          else
            render 'edit'
          end
        end

        def destroy
          User.destroy(params[:id])

          redirect_to root_path
        end

        private

        def user_params
          params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :search)
        end

        def logged_in_user
          unless logged_in?
            flash[:alert] = 'Please login'
            redirect_to login_url
          end
        end

      end
