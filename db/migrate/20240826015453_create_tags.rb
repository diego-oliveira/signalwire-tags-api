class CreateTags < ActiveRecord::Migration[7.2]
  def change
    create_table :tags do |t|
      t.string :name, index: true
      t.integer :taggings_count, default: 0

      t.timestamps
    end
  end
end
