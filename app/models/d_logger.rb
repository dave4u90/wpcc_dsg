class DLogger < ActiveRecord::Base
  def self.log(sender, message)
    self.create :name => sender.class.to_s + '=' + sender.to_json, :description => message.to_s
  end
end
