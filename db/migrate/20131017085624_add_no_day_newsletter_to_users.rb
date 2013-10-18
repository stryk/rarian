class AddNoDayNewsletterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :no_day_newsletter, :integer
  end
end
