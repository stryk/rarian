class AddIndexToTables < ActiveRecord::Migration
  def change
  	add_index :answers, :created_at
  	add_index :answers, :net_votes
  	add_index :answers, [:created_at, :net_votes]
  	add_index :answers, [:user_id, :company_id]

  	add_index :blips, :created_at
  	add_index :blips, :net_votes
  	add_index :blips, [:created_at, :net_votes]
  	add_index :blips, [:user_id, :company_id]

  	add_index :catalysts, :user_id
  	add_index :catalysts, :company_id
  	add_index :catalysts, :content
  	add_index :catalysts, :date
  	add_index :catalysts, :created_at
  	add_index :catalysts, [:user_id, :company_id]

  	add_index :comments, :created_at
  	add_index :comments, [:commentable_id, :commentable_type]
  	add_index :comments, [:created_at, :commentable_id, :commentable_type], :name => "created_id_type_ix"

  	add_index :companies, :delta

  	add_index :competitors, :user_id
  	add_index :competitors, :company_id
  	add_index :competitors, :competitor_id
  	add_index :competitors, :created_at
  	add_index :competitors, :net_votes
  	add_index :competitors, [:company_id, :competitor_id]

  	add_index :follows, :created_at

  	add_index :median_target_prices, :company_id
  	add_index :median_target_prices, :created_at
  	add_index :median_target_prices, :price
  	add_index :median_target_prices, :year
  	add_index :median_target_prices, [:company_id, :price, :year]
  	
  	add_index :most_active_tickers, :company_id
  	add_index :most_active_tickers, :active_date
  	add_index :most_active_tickers, :no_of_votes
  	add_index :most_active_tickers, [:active_date, :no_of_votes]
  	add_index :most_active_tickers, [:active_date, :company_id]
  	add_index :most_active_tickers, :created_at

  	add_index :pitches, :action
  	add_index :pitches, :user_id
  	add_index :pitches, :company_id
  	add_index :pitches, :title
  	add_index :pitches, :created_at
  	add_index :pitches, :net_votes
  	add_index :pitches, [:action, :company_id]
  	add_index :pitches, [:user_id, :company_id]
  	add_index :pitches, [:action, :company_id, :created_at], :name => "action_company_created_ix"

  	add_index :questions, :content
  	add_index :questions, :created_at
  	add_index :questions, :net_votes

  	add_index :quote_imports, :signature

  	add_index :quotes, :closing
  	add_index :quotes, :company_id
  	add_index :quotes, :created_at
  	add_index :quotes, [:company_id, :created_at]
  	add_index :quotes, [:created_at, :closing]

  	add_index :risks, :company_id
  	add_index :risks, :user_id
  	add_index :risks, :risk
  	add_index :risks, :created_at
  	add_index :risks, :net_votes

  	add_index :s3objects, :storable_type
  	add_index :s3objects, :storable_id
  	add_index :s3objects, [:storable_type, :storable_id]
  	add_index :s3objects, :key

  	add_index :target_prices, :company_id
  	add_index :target_prices, :user_id
  	add_index :target_prices, :year
  	add_index :target_prices, [:company_id, :year]

  	add_index :top_users, :user_id
  	add_index :top_users, :no_of_votes
  	add_index :top_users, :company_id
  	add_index :top_users, :created_at
  	add_index :top_users, [:company_id, :no_of_votes]

  	add_index :users, :created_at
  	add_index :users, :updated_at
  	add_index :users, :roles_mask
  	add_index :users, :up_votes
  	add_index :users, :down_votes
  	add_index :users, :name

  	add_index :votings, :created_at

  	add_index :company_groups, [:group_id, :company_id]

  end
end
