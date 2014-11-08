class Plan < ActiveRecord::Base
  # name, description, amount, stripe_plan_id
  # public, automatic_favoriting_enabled, max_search_terms, max_favorites_per_day
  has_many :user_plans

  def free?
    amount == 0
  end

end
