
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :async, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  mount_uploader :image, ImageUploader
  process_in_background :image
  store_in_background :image

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :email_user_actvity,:email_follow_me,
                  :email_answer_question, :email_comment_reply, :email_comment, :email_question, :email_answer,
                  :email_company_activity, :no_day_newsletter, :mobilenumber, :image, :aboutuser, :company, :blog, :roles
  attr_accessor :roles

  validates :mobilenumber, :numericality => true, :allow_blank => true
  validates :email, presence: true
  validates :email, uniqueness: {:case_sensitive => false},  if: -> { self.email.present? }
  validates :name, uniqueness: {:case_sensitive => false}, presence: true, length: {maximum: 15, minimum: 3}
  validates_confirmation_of :password

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :role_ids, :as => :admin



  acts_as_followable
  acts_as_follower
  make_voter

  ROLES = %w[admin moderator standard banned]

  has_many :pitches, :dependent => :destroy
  has_many :blips, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :catalysts, :dependent => :destroy
  has_many :competitors, :dependent => :destroy
  has_many :risks, :dependent => :destroy
  has_many :attachments, :dependent => :destroy


  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

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

  def slug_candidates
    [
      :name,
      [:name, :id]
    ]
  end
end

