class AddColumnDeltaToCompanies < ActiveRecord::Migration
  def change
    add_column(:companies, :delta, :boolean, :default => true)
  end
end
