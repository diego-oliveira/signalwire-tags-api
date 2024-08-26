class CreateTaggings < ActiveRecord::Migration[7.2]
  def change
    create_table :taggings do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
