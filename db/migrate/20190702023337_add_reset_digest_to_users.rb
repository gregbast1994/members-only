class AddResetDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :reset_password_digest, :string
    add_column :users, :reset_sent_at, :datetime
  end
end
