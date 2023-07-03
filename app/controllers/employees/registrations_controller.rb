# frozen_string_literal: true

class Employees::RegistrationsController < Devise::RegistrationsController
  # after_action : set_employee_id, on: :create
  #before_action :authenticate_employee!
  respond_to :json


  def create
    employee = Employee.create(employee_params)
    # authorize employee
    if employee.save
      render json: {message: "Employee Signed Up Successfully",data: employee}, status: 200
    else
      render json: {message: "Employee Cannot be created", error: employee.errors.full_messages}
    end
  end


   private
   def respond_with(resource, options={})
    # authorize employee
    if resource.persisted?
      render json: {
        status: { code: 200, message: "Signed up Successfully", data: resource }

      }, status: :ok
    else
      render json: {
         status: { message: "Employee could not be created", errors: resource.errors.full_messages}, status: :unprocessable_entity
      }
    end
   end

  def employee_params
    params.require(:employee).permit(:email,:password,:name,:role, :manager_name, :manager_id)
  end
end



