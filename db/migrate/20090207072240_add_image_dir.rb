class AddImageDir < ActiveRecord::Migration
  def self.up
    add_column :photos, :image_dir, :string
  end

  def self.down
    remove_column :photos, :image_dir
  end
end
