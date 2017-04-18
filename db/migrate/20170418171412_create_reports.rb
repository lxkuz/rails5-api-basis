class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :title
      t.json :data
      t.string :file
      t.datetime :report_from
      t.datetime :report_to
      t.timestamps
    end
  end
end
