class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :gig, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: {to_table: :users}
      t.references :freelancer, null: false, foreign_key: {to_table: :users}
      t.integer :status, null: false, default: 0
      t.integer :price_cents, null: false

      t.timestamps
    end

    add_index :orders, :status
  end
end
