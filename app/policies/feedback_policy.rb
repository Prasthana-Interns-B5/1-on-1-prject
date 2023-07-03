class FeedbackPolicy < ApplicationPolicy
  # class Scope < Scope
  #   # NOTE: Be explicit about which records you allow access to!
  #   # def resolve
  #   #   scope.all
  #   # end
  # end
  attr_reader :employee, :record

  def initialize(employee, record)
    @employee = employee
    @record = record
  end
  
  def index?
    @employee.manager? 
  end  

  def show?
    @employee.id == @record.employee_id || @employee.id == @record.manager_id
  end

 
  def create?
    @employee.subordinate?
  end

  def update?
    @employee.id == @record.employee_id
  end

  def destroy?
    @employee.id == @record.employee_id
  end

  def manager_feedback?
    @employee.id == @record.manager_id
   end

   def comments?
    @employee.id == @record.employee_id 
   end
  
end
