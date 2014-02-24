class IsLanguageSupported < ActiveRecord::Migration
  def change
    add_column :languages, :is_supported, :boolean, :default => false      
  end
end
