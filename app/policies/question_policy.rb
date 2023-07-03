class QuestionPolicy
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

  def index
    @employee.id == @record.manager_id || @employee.id == @record.employee_id

  def destroy?
    @employee.id == @record.employee_id
  end

  def query_answer
    @employee.manager? 
  end  

  def answer_opinion
    @employee.id == @record.employee_id
  end  

end
