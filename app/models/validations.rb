class Validations < ActiveRecord::Base
  has_many :literals, :as => :literal_identifier
end
