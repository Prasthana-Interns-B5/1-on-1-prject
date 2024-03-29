class EmployeesController < ApplicationController
  before_action :find_params, except: [:index, :create, :current_employee_info, :subordinates, :all_employees] 
  before_action :authorize_employee, except: [:index, :current_employee_info, :subordinates, :all_employees]

  def index
    employee = Employee.filter(params)
    render json: employee, status: 200
  end

  def show
    render json: @employee, status: 200
  end

  def update
    if @employee.update(employee_params)
      render json: @employee, status: 200
    else
      render json: {message: "Employee cannot be updated", error: @employee.errors.full_messages}
    end
  end

  def destroy
    @employee.destroy
    render json: {message: "Record Destroyed Successfully"}
  end

  def subordinates
    employee = current_employee
    if employee.role = "ur_manager"
      subordinates = Employee.where(reporting_manager_id:employee.id)
      render json: subordinates, status: 200
    end 
  end

  def all_employees
    employees = Employee.all
    render json: employees, status: 200
  end

 
  def queries
    queries = @employee.questions
    render json: queries, status: 200
  end

  def scores
    scores = @employee.points
    render json: scores, status: 200
  end

  def reviews
    feedback=@employee.feedbacks
    render json: feedback ,status:200
  end

  def current_employee_info
    render json: current_employee
  end

  private

  def authorize_employee
    unless authorize @employee
      flast[:alert] = "You are not authorized to perform this action"
    end
  end

  def find_params
    @employee = Employee.find(params[:id])
  end

  def employee_params 
    params.require(:employee).permit(:email, :password, :name, :role, :reporting_manager_id, :employee_no, :mobile_number)
  end

  
end