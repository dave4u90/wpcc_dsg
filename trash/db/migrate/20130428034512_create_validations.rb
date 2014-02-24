class CreateValidations < ActiveRecord::Migration
  def change
    create_table :validations do |t|
      t.primary_key :id
      t.string :title
      t.string :expr

      t.timestamps
    end
  end
end
