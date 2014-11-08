class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable,
         :omniauth_providers => [:twitter]

  has_one :user_plan

  validates_presence_of :unsubscribe_token
  before_validation :set_unsubscribe_token

  def email_required?
    super && provider.blank?
  end

  def password_required?
    super && provider.blank?
  end

  def to_s
    username || email
  end

  def plan
    user_plan ? user_plan.plan : DefaultPlan.new
  end

end
