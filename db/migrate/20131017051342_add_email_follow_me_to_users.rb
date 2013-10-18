class AddEmailFollowMeToUsers < ActiveRecord::Migration
  def change

    add_column :users, :email_vote, :boolean
    add_column :users, :email_follow_me, :boolean
    add_column :users, :email_answer_question, :boolean
    add_column :users, :email_sends_message, :boolean
    add_column :users, :email_comment, :boolean
    add_column :users, :email_question, :boolean
    add_column :users, :email_answer, :boolean




  end
end
