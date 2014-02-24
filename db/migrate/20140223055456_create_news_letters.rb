class CreateNewsLetters < ActiveRecord::Migration
  def change
    create_table :news_letters do |t|
      t.string :full_name
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
