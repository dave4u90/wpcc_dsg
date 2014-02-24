namespace :db do
  require 'csv'
  desc "exporting db list"
  task :reset_custom => :environment do
    ActiveRecord::Base.connection.tables.each do |table|
      next if table.match(/\Aschema_migrations\Z/)
      if !(table.to_s == 'cities' or table.to_s == 'metadata' or
          table.to_s == 'metafield' or table.to_s == 'product_instances_languages' or
          table.to_s == 'user_access' or table.to_s == 'validations' or table.to_s == 'field_maps' )
        #omitted tables are not following good practices rails, there were some errors when loading
        #eg: table -> cities, class -> cities, it should be table-> cities, class City
        klass = table.singularize.camelize.constantize
        puts "Exporting #{table} ..."
        CSV.open("lib/assets/test/#{klass.name}.csv", "wb", :col_sep => ',') do |csv|
          record = Array.new
          csv << klass.column_names
          klass.all.each do |c|
            c.attributes.each do |k,v|
              record << v
            end
            csv << record
          end
        end
        puts "table #{table} successfully exported"
      end
    end

    # Add omitted tables
    tables = {"Cities" => "cities", "MetaData" => "metadata", "MetaField" => "metafield", "ProductInstanceLanguage" =>
              "product_instances_languages", "UserAccess" => "user_access", "Validations" => "validations"}
              #"FieldMap" => "field_maps"}
    tables.each do |k, v|
      table = k.constantize
      puts "Exporting #{table} ..."
      CSV.open("lib/assets/test/#{table.name}.csv", "wb", :col_sep => ',') do |csv|
        record = Array.new
        csv << table.column_names
        table.all.each do |t|
          t.attributes.each do |k,v|
            record << v
          end
          csv << record
        end
      end
      puts "table #{table} successfully exported"
    end
    Rake::Task["db:reset"].execute
  end

end
