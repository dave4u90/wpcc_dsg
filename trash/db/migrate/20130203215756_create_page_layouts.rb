class CreatePageLayouts < ActiveRecord::Migration
  def change
    create_table :page_layouts do |t|
      t.string :page_layout_description

      t.timestamps
    end
  end
end
