class RegistrationsController < Devise::RegistrationsController
    def create
      super do |resource|
        if resource.persisted?
          flash[:notice] = "Successfully signed up!"
        else
          flash[:alert] = "Registration failed. Please try again."
        end
      end
    end
end