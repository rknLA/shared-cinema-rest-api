class CreateSubmittedVideo < ActiveRecord::Migration
  def change 
    create_table(:submitted_videos) do |t|
      t.integer :user_id, :null => false
      t.integer :upvotes, :null => false, :default => 0

      t.string :youtube_video_id, :null => false, :default => ''
      t.string :title
      t.string :duration

      t.datetime :started_at
      t.datetime :finished_at
    end

    add_index :submitted_videos, :user_id
    add_index :submitted_videos, :upvotes
  end
end
