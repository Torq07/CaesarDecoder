class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text :content
      t.integer :shift

      t.timestamps null: false
    end
  end
end
