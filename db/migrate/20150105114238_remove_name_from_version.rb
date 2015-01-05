class RemoveNameFromVersion < ActiveRecord::Migration
  def change
    change_table :versions do |t|
      t.remove :name
    end
  end
end
