class PlansController < ApplicationController
  before_filter :find_plan_or_fail, only: [:checkout, :purchase]

  def index
    @current_plan = current_user.plan if current_user
    @plans = [DefaultPlan.new] + Plan.where(public: true)
  end

  def checkout

  end

  def purchase
    card_token = params[:stripeToken]

    purchaser = StripePlanPurchaser.new(
      card_token, @plan.stripe_plan_id, current_user)

    if purchaser.purchase_plan!
      user_plan = UserPlan.create(
        plan: @plan,
        user: current_user,
        stripe_subscription_id: purchaser.subscription_id,
        stripe_customer_id: purchaser.customer_id
      )

      flash[:alert] = nil
      flash[:notice] = "Your plan was purchased successfully."
      redirect_to dashboard_path
    else
      flash[:alert] = "An error occurred purchasing this plan: #{purchaser.error}"
      render :checkout
    end
  end

  private

  def find_plan_or_fail
    @plan = Plan.find_by_id(params[:id])
    redirect_to dashboard_path unless @plan
  end

end
