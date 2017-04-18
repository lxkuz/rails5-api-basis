class CreateTicketKinds < ActiveRecord::Migration[5.0]
  def change
    create_table :ticket_kinds do |t|
      t.string :name
      t.timestamps
    end
  end
end
