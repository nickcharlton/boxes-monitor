class AddTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
