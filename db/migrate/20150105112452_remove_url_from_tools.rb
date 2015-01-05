class RemoveUrlFromTools < ActiveRecord::Migration
  def change
    change_table :tools do |t|
      t.remove :url
    end
  end
end
