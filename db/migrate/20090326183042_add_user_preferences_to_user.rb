class AddUserPreferencesToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :per_page, :integer
    add_column :users, :stylesheets, :string
  end

  def self.down
    remove_column :users, :per_page
    remove_column :users, :stylesheets
  end
end
