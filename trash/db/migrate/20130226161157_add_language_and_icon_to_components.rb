class AddLanguageAndIconToComponents < ActiveRecord::Migration
  def change
  	add_column :components, :language_id, :integer
  	add_column :components, :icon_url, :string
  end
end
