class CreateAuditTrails < ActiveRecord::Migration
  def change
    create_table :audit_trails do |t|
      t.integer :audit_trail_message_id
      t.integer :user_id
      t.primary_key :id
      t.string :ip_address

      t.timestamps
    end
  end
end
