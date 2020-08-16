class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :title
      t.string :color
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
