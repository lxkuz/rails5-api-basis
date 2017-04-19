class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :name
      t.text :description
      t.integer :ticket_kind_id
      t.integer :customer_id
      t.integer :agent_id
      t.datetime :closed_at
      t.text :closing_description
      t.string :status, default: 'new'
      t.timestamps
    end

    add_index :tickets, :ticket_kind_id
    add_index :tickets, :agent_id
    add_index :tickets, :customer_id
  end
end
