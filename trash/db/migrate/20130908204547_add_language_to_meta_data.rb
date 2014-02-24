class AddLanguageToMetaData < ActiveRecord::Migration
  def change
    add_column :metadata, :language_id, :integer, default: 1
  end
end
