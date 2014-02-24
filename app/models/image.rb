
require 'carrierwave/orm/activerecord'

class Image < ActiveRecord::Base

  
  mount_uploader :image_url, ImageUploader
  
  def get_size_by_width(w)
    h = (self.height_width_ratio * w).ceil
    return w.to_s + "x" + h.to_s   
  end
  def to_s()
    return self.image_url
  end
  
  def self.get_not_found_image()
    return get_image_url(nil)
  end
  
  def self.get_image_url(img)
    #this method will check to see if the ImageUploader file exists- if it doesnt then it will return
    #--just the file so that it can be picked up from images folder
    
    if img == nil
      return "not_found.png"
    end
    
  
    if File.exists? (Rails.root + img.image_url.path)
      return img.image_url
    else
      return img.image_url.file.filename
    end    
  end  
end
