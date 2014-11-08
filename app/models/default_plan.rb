class DefaultPlan

  def name
    "Basic"
  end

  def description
    "Get started favoriting tweets"
  end

  def amount
    "Free"
  end

  def stripe_plan_id
    nil
  end

  def public
    true
  end

  def max_search_terms
    1
  end

  def free?
    true
  end

end
