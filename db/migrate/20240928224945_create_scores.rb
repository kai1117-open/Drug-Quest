class CreateScores < ActiveRecord::Migration[7.0]
  def change
    create_table :scores do |t|
      t.integer :cashier_score
      t.integer :claim_score
      t.integer :order_score
      t.integer :replenishing_score
      t.integer :user_id
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
