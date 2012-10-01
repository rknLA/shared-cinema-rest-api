class CreateVotes < ActiveRecord::Migration
  def change
    create_table(:votes) do |t|
      t.integer :video_id, :null => false
      t.integer :user_id, :null => false
    end

    add_index :votes, :video_id
    add_index :votes, :user_id
  end
end
