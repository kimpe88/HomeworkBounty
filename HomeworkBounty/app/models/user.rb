class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

	# Username is id
	field :_id, type: String, default: ->{ username }
	field :username, type: String
	validates_uniqueness_of :username

  field :email,              type: String, default: ""
  validate :student_email
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Role
	field :role,								 type: String, default: "guest"
  validate :validate_roles

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  # Own fields
	belongs_to :school, :class_name => 'School'
	has_many :questions, :class_name => 'Question'
	has_many :answers, :class_name => 'Answer', inverse_of: :answer_author


	def to_s
		"Username #{username}, email #{email}"
	end
	def role?(role)
		self.role == role.to_s
	end
end

private
def validate_roles 
	if not ['guest', 'user', 'admin'].include? self.role
		errors[:role] << " is not valid"
	end
end
def student_email
	if not self.email =~ /#{school.email_domain}$/i
		errors[:email] << "does not match school email domain"
	end
end
