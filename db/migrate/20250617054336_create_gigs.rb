class CreateGigs < ActiveRecord::Migration[7.1]
  def change
    create_table :gigs do |t|
      t.string     :title,       null: false, limit: 150
      t.text       :description, null: false
      t.integer    :price_cents, null: false, default: 0
      t.references :user,        null: false, foreign_key: true

      t.timestamps
    end

    add_index :gigs, :title
  end
end
