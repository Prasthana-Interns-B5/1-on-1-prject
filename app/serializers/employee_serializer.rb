class EmployeeSerializer < ActiveModel::Serializer
 attributes :id, :employee_no, :name, :email, :role, :manager_name, :manager_id,:notification,:meeting_notifications








  def  notification
  
    month=Date.new(Time.now.year,Time.now.month)
    feedback=object.feedbacks.where(created_at: month.beginning_of_month..month.end_of_month-10)
    if !feedback.select(:self_feedback).exists? && !feedback.select(:self_feedback).nil?
      return "please fill the feedback"
    elsif !feedback.select(:manager_feedback).nil?
      return "Manager has to fill the feedback"  
    else
      return "You are ready to attend the metting"
    end
  end


  def meeting_notifications
    month=Date.new(Time.now.year,Time.now.month)
    subordinate=object.subordinates
    subordinate.map do |s|
      feedback=s.feedbacks.where(meeting: false).where(created_at: month.beginning_of_month..month.end_of_month-8)
      feedback.map do |f|
        if !f.nil?
          "conduct a 1-1 meeting for #{s.id}"
        end
      end
    end
  end

end

