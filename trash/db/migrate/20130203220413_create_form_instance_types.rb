class CreateFormInstanceTypes < ActiveRecord::Migration
  def change
    create_table :form_instance_types do |t|
      t.string :form_instance_desc

      t.timestamps
    end
  end
end
