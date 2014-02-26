class CreateEnquiries < ActiveRecord::Migration
  def change
    create_table :enquiries do |t|
      t.string :name
      t.string :email
      t.string :telephone
      t.text :message

      t.timestamps
    end
  end
end
