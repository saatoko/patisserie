class DropComment < ActiveRecord::Migration[5.0]
  def up
    drop_table :comments
  end

  def down
    create_table :comments do |t|
      t.references :user,   foreign_key: true
      t.references :recipe, foreign_key: true
      t.text       :text,   null: false
      t.timestamps
    end
  end
end