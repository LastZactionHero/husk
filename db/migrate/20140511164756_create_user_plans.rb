class CreateUserPlans < ActiveRecord::Migration
  def change
    create_table :user_plans do |t|
      t.integer :user_id
      t.integer :plan_id
      t.string :stripe_subscription_id
      t.string :stripe_customer_id
      t.datetime :expires_at

      t.timestamps
    end

    add_index :user_plans, :user_id
    add_index :user_plans, :plan_id
  end
end
