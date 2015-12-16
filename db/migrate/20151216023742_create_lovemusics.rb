class CreateLovemusics < ActiveRecord::Migration
  def change
    create_table :lovemusics do |t|
      t.string :loveword

      t.timestamps null: false
    end
  end
end
