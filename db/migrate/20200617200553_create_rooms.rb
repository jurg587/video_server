class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :guid
      t.bigint :capacity_limit, default: 5

      t.timestamps
    end
  end
end
