class AddExifData < ActiveRecord::Migration
  def self.up
    add_column :photos, :iso, :string
    add_column :photos, :aperture, :string
    add_column :photos, :shutterspeed, :string
    add_column :photos, :focallength, :string
    add_column :photos, :date, :datetime
  end

  def self.down
    remove_column :photos, :iso
    remove_column :photos, :aperture
    remove_column :photos, :shutterspeed
    remove_column :photos, :focallength
    remove_column :photos, :date
  end
end
