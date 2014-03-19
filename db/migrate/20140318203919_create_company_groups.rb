class CreateCompanyGroups < ActiveRecord::Migration
  def change
    create_table :company_groups do |t|
      t.string :name
      t.integer :group_id
      t.integer :company_id
      t.timestamps
    end
    create_table :groups do |t|
    	t.string :name
    	t.string :description
    end
    add_index :company_groups, :name
    add_index :company_groups, :group_id
    add_index :company_groups, :company_id
    add_index :groups, :name
  end
end
