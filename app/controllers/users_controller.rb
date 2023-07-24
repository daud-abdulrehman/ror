class UsersController < ApplicationController

    def index
        render json: {users: User.all}
    end

    def create
        begin
          # Extract user data from the request parameters
          user_params = params.require(:user).permit(:name, :email)
    
          # Perform necessary validation on the data (e.g., checking if required fields are present)
    
          # Save the new user to the database
          user = User.create(user_params)
    
          # Return a success response
          render json: { message: 'User created successfully!' }, status: :created
          render json: {users: User.all}

        rescue => e
          # Handle any errors that may occur during the process
          render json: { error: 'An error occurred while creating the user.' }, status: :internal_server_error
        end
      end

      def update
        begin
          # Find the user based on the provided ID
          user = User.find(params[:id])
    
          # Extract updated user data from the request parameters
          user_params = params.require(:user).permit(:username, :email, :password)
    
          # Perform necessary validation on the data (e.g., checking if required fields are present)
    
          # Update the user's information in the database
          user.update(user_params)
    
          # Return a success response
          render json: { message: 'User updated successfully!' }, status: :ok
          render json: {users: User.all}

        rescue => e
          # Handle any errors that may occur during the process
          render json: { error: 'An error occurred while updating the user.' }, status: :internal_server_error
        end
      end

    def edit
        begin
          # Find the user based on the provided ID
          user = User.find(params[:id])
    
          # Return the user's information as a JSON response (or you can render an HTML form)
          render json: user, status: :ok
        rescue ActiveRecord::RecordNotFound
          # Handle the case when the user with the provided ID is not found
          render json: { error: 'User not found.' }, status: :not_found
          render json: {users: User.all}

        rescue => e
          # Handle any other errors that may occur during the process
          render json: { error: 'An error occurred while fetching the user.' }, status: :internal_server_error
        end
    end

    def show
      @user = User.find(params[:id])
      @comments = @user.comments
    end

end
