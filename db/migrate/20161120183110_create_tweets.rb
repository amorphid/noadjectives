class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets  do |t|
      t.text     :text
      t.bigint   :twitter_id
      t.text     :pos_tagged_text
      t.datetime :twitter_created_at

      t.timestamps null: false
    end
  end
end
