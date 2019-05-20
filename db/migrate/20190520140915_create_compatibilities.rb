class CreateCompatibilities < ActiveRecord::Migration[5.2]
  def change
    create_table :compatibilities do |t|
      t.belongs_to :stuffed_animal, index: true
      t.belongs_to :accessory, index: true
      t.timestamps
    end
  end
end
