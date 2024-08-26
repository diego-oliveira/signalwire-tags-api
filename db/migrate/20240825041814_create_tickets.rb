class CreateTickets < ActiveRecord::Migration[7.2]
  def change
    create_table :tickets do |t|
      t.string :title, null: false, index: true
      t.integer :user_id, null: false, index: true

      t.timestamps

      t.index [:title, :user_id]
    end
  end
end
