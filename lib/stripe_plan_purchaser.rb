class StripePlanPurchaser
  attr_reader :error
  
  def initialize(stripe_card_token, stripe_plan_id, user)
    @stripe_card_token = stripe_card_token
    @stripe_plan_id = stripe_plan_id
    @user = user
  end

  def purchase_plan!
    Stripe.api_key = APP_SETTINGS["stripe"]["api_key"]

    begin
    @response = Stripe::Customer.create(
      description: @user.to_s,
      plan: @stripe_plan_id,
      card: @stripe_card_token)
      true
    rescue Stripe::CardError => e
      @error = e.message
      false
    end
  end

  def subscription_id
    @response["subscriptions"]["data"][0]["id"]
  end

  def customer_id
    @response["id"]
  end

end
