class AddVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :name
      t.string :version

      # iso checkers store the checksum and iso path
      t.string :checksum
      t.string :iso_url

      # github checkers store the commit
      t.string :commit_hash

      t.references :tool

      t.timestamps
    end
  end
end
