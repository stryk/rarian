class AddColumnEmailSpamToUsers < ActiveRecord::Migration
  def change
    add_column(:users, :email_spam, :boolean, :default => false)
  end
end
