class CreateFormInstanceVersions < ActiveRecord::Migration
  def change
    create_table :form_instance_versions do |t|
      t.integer :form_instance_id
      t.integer :user_id
      t.integer :version
      t.integer :revision

      t.timestamps
    end
  end
  
end
