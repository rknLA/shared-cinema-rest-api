# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121001045028) do

  create_table "submitted_videos", :force => true do |t|
    t.integer  "user_id",                          :null => false
    t.integer  "upvotes",          :default => 0,  :null => false
    t.string   "youtube_video_id", :default => "", :null => false
    t.string   "title"
    t.string   "duration"
    t.datetime "started_at"
    t.datetime "finished_at"
  end

  add_index "submitted_videos", ["upvotes"], :name => "index_submitted_videos_on_upvotes"
  add_index "submitted_videos", ["user_id"], :name => "index_submitted_videos_on_user_id"

  create_table "votes", :force => true do |t|
    t.integer "video_id", :null => false
    t.integer "user_id",  :null => false
  end

  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"
  add_index "votes", ["video_id"], :name => "index_votes_on_video_id"

end
