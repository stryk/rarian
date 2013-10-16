class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :email_vote,:email_follow_me,
                  :email_answer_question, :email_sends_message, :email_comment, :email_question, :email_answer, :email_spam, :no_day_newsletter, :mobilenumber
  attr_accessor :roles

  make_voter

  ROLES = %w[admin moderator standard banned]

  has_many :pitches
  has_many :blips
  has_many :questions
  has_many :answers
  has_many :comments

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  def get_contributions
    {"Alpha Blips" => blips.count, "Buy/Sell" => pitches.count,
     "Question" => questions.count, "Answers" => answers.count,
     "Comments" => comments.count}
  end

  def get_contributions_by_company
    (Blip.unscoped.select("count(*) as count, company_id, user_id").group("company_id, user_id").where(:user_id => current_user.id) +
      Pitch.unscoped.select("count(*) as count, company_id, user_id").group("company_id, user_id").where(:user_id => current_user.id) +
      Question.unscoped.select("count(*) as count, company_id, user_id").group("company_id, user_id").where(:user_id => current_user.id) +
      Answer.unscoped.select("count(*) as count, company_id, user_id").group("company_id, user_id").where(:user_id => current_user.id) +
      Comment.unscoped.select("count(*) as count, company_id, user_id").group("company_id, user_id").where(:user_id => current_user.id)).
      group(&:company_id)
  end

end
