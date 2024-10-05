class RemovePassFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :pass, :string
  end
end
