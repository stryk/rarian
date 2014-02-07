class FixColumnNames < ActiveRecord::Migration
  def change
  	change_table :users do |t|
      t.rename :email_spam, :email_company_activity
      t.rename :email_vote, :email_user_activity
      t.rename :email_sends_message, :email_comment_reply
      t.datetime :last_emailed_at, default: Time.now
    end
  end
end
