# frozen_string_literal: true

class Employees::RegistrationsController < Devise::RegistrationsController
  
  respond_to :json
 
  def create_first_employee
    if Employee.count==0 
    employee = Employee.new(employee_params)
    employee.password='123456'
    if role_check(employee.role) && employee.save
      render json: {message: "Employee Signed Up Successfully",data: employee}, status: 201
    else
      render json: {message: "Employee Cannot be created", error: employee.errors.full_messages},status: 422
    end
    else
      render json: {message: "Employee Can be created by HR only"},status: 422
    end 
 end

  def create
    employee = Employee.new(employee_params)
    authorize employee
    employee.password='123456'
    if employee.save
      render json: {message: "Employee Signed Up Successfully",data: employee}, status: 201
      EmailMailer.signup_email(employee.email).deliver_now
    else
      render json: {message: "Employee Cannot be created", error: employee.errors.full_messages}
    end
  end

  
  
   private

   def respond_with(resource, options={})
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
    params.require(:employee).permit(:email, :password, :name, :role, :reporting_manager_id, :employee_no, :mobile_number)
  end

  def role_check(role)
       role=='ur_hr'
  end

end



