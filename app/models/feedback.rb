class Feedback < ApplicationRecord
    belongs_to :employee ,optional: true, default: -> {Current.employee}

    before_create :save_manager_id, :save_employee_id

    def save_manager_id
        self.manager_id = Current.employee.manager_id
    end
    def save_employee_id
        self.employee_id = Current.employee.id
    end
end



