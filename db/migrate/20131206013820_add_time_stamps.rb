class AddTimeStamps < ActiveRecord::Migration
  def change
    add_timestamps :shortened_urls
    add_timestamps :users
    add_timestamps :visits
  end
end
