class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.string :name
      t.boolean :check
      t.string :guest
      t.boolean :weekend
      t.string :email

      t.timestamps
    end
  end
end
