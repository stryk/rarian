class AddColumnCompanyIdToTopUsers < ActiveRecord::Migration
  def change
    add_column(:top_users, :company_id, :integer)
  end
end
