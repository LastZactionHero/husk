class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.text :description
      t.decimal :amount, precision: 6, scale: 2

      t.timestamps
    end
  end
end
