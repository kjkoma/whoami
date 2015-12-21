class CreateLovemovies < ActiveRecord::Migration
  def change
    create_table :lovemovies do |t|
      t.string :loveword

      t.timestamps null: false
    end
  end
end
