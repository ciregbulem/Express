class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

   # For Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:linkedin]

  has_many :friendships
  has_many :employers, :through => :friendships

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  def self.find_for_oauth(auth, signed_in_resource = nil)

      # Get the identity and student if they exist
      identity = Identity.find_for_oauth(auth)

      # If a signed_in_resource is provided it always overrides the existing student
      # to prevent the identity being locked with accidentally created accounts.
      # Note that this may leave zombie accounts (with no associated identity) which
      # can be cleaned up at a later date.
      student = signed_in_resource ? signed_in_resource : identity.student
        # Create the student if needed
        if student.nil?

          # Get the existing student by email if the provider gives us a verified email.
          # If no verified email was provided we assign a temporary email and ask the
          # student to verify it on the next step via studentsController.finish_signup
          email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
          email = auth.info.email if email_is_verified
          student = Student.find_by email: auth.info.email

  	    # Creates the student if it's a new registration
  	    if student.nil?
  	      student = Student.new(
  	        first_name: auth.info.first_name,
  	        last_name: auth.info.last_name,
  	        email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
  	        temp_email: auth.info.email,
  	        linkedin_link: auth.extra.raw_info.publicProfileUrl,
  	        password: Devise.friendly_token[0,20], 
  	      )
  	      student.skip_confirmation! if student.respond_to?(:skip_confirmation)
  	      student.save!
  	    end
      end

      # Associate the identity with the student if needed
      if identity.student != student
        identity.student = student
        identity.save!
      end
      student
    end

    def email_verified?
      self.email && self.email !~ TEMP_EMAIL_REGEX
    end
end
