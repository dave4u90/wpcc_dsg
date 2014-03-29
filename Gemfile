source 'https://rubygems.org'

ruby "1.9.3"

gem 'rails', '3.2.2' 
gem 'bootstrap-sass', '~> 2.2.2.0'
gem 'bcrypt-ruby', '3.0.1'
gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'
gem 'prawn'
gem 'jquery-ui-rails'
gem 'jquery-cookie-rails'
gem "recaptcha", :require => "recaptcha/rails"
gem 'ckeditor'
gem 'redactor-rails'
gem "jquery-fileupload-rails"
gem 'mysql2'


gem "therubyracer"

gem "execjs"


gem "less-rails"
gem 'twitter-bootstrap-rails', github: 'seyhunak/twitter-bootstrap-rails'


group :development do
	gem 'rails-erd'
	gem 'annotate', '2.5.0'
	gem 'sqlite3', '1.3.5'
	gem 'rspec-rails', '2.11.0'
	gem 'guard-rspec', '1.2.1'
	
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

gem 'jquery-rails', '2.3.0'
gem 's3_direct_upload'
gem 'paperclip', '3.0.4'
gem 'cocaine', '0.3.2'
gem 'remotipart', '~> 1.2'
gem 'aws-sdk'

# Test gems on Mac OS X
group :test do
	gem 'capybara', '1.1.2'
	gem 'factory_girl_rails', '4.1.0'
	gem 'rb-fsevent', '0.9.1', :require => false
	gem 'growl', '1.0.3'
	gem 'guard-spork', '1.2.0'
	gem 'spork', '0.9.2'
end

group :image do
	if RUBY_PLATFORM =~ /(win|w)32$/
	 gem 'rmagick', '2.13.2',  :require => 'RMagick'
        else
	 gem 'rmagick', :require => 'RMagick'
        end
	gem "carrierwave"
end

group :production do
	gem 'pg'
end


group :email do
   gem 'mail'
end