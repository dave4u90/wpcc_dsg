class ProductKey < ActiveRecord::Base
  belongs_to :product_type
  belongs_to :product_instance

  validates :product_type_id, presence: true
  validates :product_key, presence: true, uniqueness: true
  validates :client_id, presence: true

  def self.new_key(product_type)
    #generate a new product_instance_registration_key

    #key mechanism: AAA-BBBB-CCCC-DDDD-EE
    #AAA = product_type_id x 11 mod 999
    #BBBB = product_type.created_at.year
    #CCCC = random_number
    #DDDD = max(product_instance_id) x 11 mod 9999

    a = (product_type.id * 1111) % 999
    b = product_type.created_at.year
    c = rand(9999)
    d = ProductKey.maximum(:id)
    if d == nil
      d=1
    end

    e = a+b+c+d

    key = ProductKey.new
    key.product_type_id = product_type.id
    key.product_key = a.to_s + "" + b.to_s + "" + c.to_s + "" + d.to_s + "" + e.to_s
    key.save

    return key
  end

  def self.formatted_product_key(pk)
    split_key_size = 4
    split_key_chr = "-"

    if pk.nil?
      return "naada"
    end

    s = ""
    i = 0
    k = pk.split("")
    k.each do |c|
      s += c.to_s
      i += 1
      if i % split_key_size == 0 && i < k.size
        s += split_key_chr
      end
    end

    return s

  end

  def self.get_product_type(product_key)
    #assume its a valid key
    key = ProductKey.where ("product_key='" + product_key + "'")
    if key.empty?
      return 0
    else
      return key.first.product_type_id
    end
  end


  def to_s()
    return ProductKey.formatted_product_key(self.product_key)
  end

  def self.valid_key(key)
    key_string = ProductKey.clean_key(key)
    keys = ProductKey.pluck(:product_key) + ProductInstance.pluck(:product_key)
    valid = keys.include? key_string
    valid
  end

  def self.clean_key(key)

    chr_clean = "-_"
    chr_array = chr_clean.split ("")

    #clean the key first
    my_key = key.to_s.lstrip.to_s.rstrip.to_s

    chr_array.each do |c|
      my_key = my_key.gsub c, ""
    end
    return my_key.to_s

  end

  def self.key_in_use(key)
    key.present? ? ProductInstance.pluck(:product_key).include?(key) : false
  end

  def find_by_product_key(key)
    key_string = ProductKey.clean_key(key)
    ProductKey.where("product_key='" + key_string + "'")
  end

  def self.get_unused_key(product_type)
    res = ProductKey.where ("product_type_id='" + product_type.id.to_s + "'")
    if res.empty?
      return self.new_key (product_type)
    else
      res.each do |r|
        res2 = ProductInstance.product_instance_by_key (r)
        if res2 == nil
          return r
        end
      end
    end
  end
end
