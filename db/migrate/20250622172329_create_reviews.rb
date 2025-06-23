class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :rating, null: false
      t.text :comment

      t.timestamps
    end

    # add_index :reviews, :order_id, unique: true        ## Will check later, giving error on indexing.
  end
end
