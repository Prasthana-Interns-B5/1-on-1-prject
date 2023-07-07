class Employee < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self


         has_many :employee_roles, dependent: :destroy
         has_many :roles, through: :employee_roles
         has_many :questions
         has_many :answers
         has_many :points
         has_many  :feedbacks
      
  # ROLES = %w{HR manager subordinate}

  def jwt_payload
    super
  end


  # ROLES.each do |role_name|
  #   define_method "#{role_name}?" do
  #     role == role_name
  #   end
  # end

  # has_many :subordinates, class_name: "Employee", foreign_key: "manager_id"

  # belongs_to :manager, class_name: "Employee", optional: true



  after_create :set_employee_no

  private


  def set_employee_no
    self.employee_no = "2023-#{self.id}"
  end

end
