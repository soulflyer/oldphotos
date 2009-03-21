class AddExifData < ActiveRecord::Migration
  def self.up
    add_column :photos, :iso, :string
  end

  def self.down
    remove_column :photos, :iso
  end
end
