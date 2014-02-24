class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :status_text
      t.string :status_icon_url
      t.string :status_description
      t.integer :sequence

      t.timestamps
    end
  end
end
