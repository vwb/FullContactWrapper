class CreateCachedPeople < ActiveRecord::Migration
  def change
    create_table :cached_people do |t|
      t.string :email, null: false, index: true, unique: true
      t.string :data, null: false
      t.timestamps null: false
    end
  end
end
