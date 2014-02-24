# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  abbrev     :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'carrierwave/orm/activerecord'

class Component < ActiveRecord::Base

  attr_accessible :component_type_id, :component_description, :image_id, :photo, :parent_component_id,
                  :literals_attributes, :image_attributes

  belongs_to :component_type
  
  has_many :custom_components
  
  belongs_to :parent_component, :class_name => "Component", :foreign_key => "parent_component_id"

  has_many :component_hierarchy
  
  has_many :sub_components, :class_name => "ComponentHierarchy", :foreign_key => "parent_component_id"
  
  
  has_many :meta_data 
  has_many :meta_field
  has_many :product_type_components

  has_many :product_types, :through => :product_type_components
  
  has_many :literals, :as => :literal_identifier

  #Formplate relationship
  has_many :component_formplates
  has_many :formplates, :through => :component_formplates, :order => "sequence ASC"
  
  belongs_to :image

  mount_uploader :photo, ImageUploader

  after_create :create_hierarchy

  accepts_nested_attributes_for :literals, :allow_destroy => true
  accepts_nested_attributes_for :image, :allow_destroy => true

  def get_image()
    if self.image.nil?
      return nil
    else
      return self.image
    end
  end
  
  def notes(product_instance)
    my_notes = []
    product_instance.notes.each do |n|
      if n.component_id == self.id
        my_notes.push n
      end
    end
    return my_notes
  end
  
  def get_title(language_id)
    if self.literals.size >= 1 
      l = self.literals.first.get_literal(language_id)
      return l.literal
    else
      if component_description == nil
        return artificial_title
      else
        return component_description
      end
    end    
  end
  
  
  def get_components()
    #holder array
    comps = []
    
    #counters
    i=0
    j=0
    
    #temp
    t = nil
    
    array_comp = self.sub_components.to_a
    

    new_array = []
    
    #remove nils
    array_comp.each do |c|
      if c.component != nil
        new_array.push c
      end      
    end

    
    while i < new_array.size do
      j = i+1
      t = new_array[i]
      while j < new_array.size do
        if t!= nil && new_array[j] != nil
          if t.sequence != nil && new_array[j].sequence != nil
            if t.sequence > new_array[j].sequence
             t = new_array[j]
            end
          end
        end      
        j+=1
      end
      i+=1
      if t!= nil
        comps.push t.component
      end      
    end

    return comps
  end

  def get_formplates()
    #holder array
    fplates = []
    
    #counters
    i=0
    j=0
    
    #temp
    t = nil
    
    array_fplates = self.component_formplates
    
    
    new_array = []
    
    #remove nils
    array_fplates.each do |c|
      if c.formplate != nil
        new_array.push c
      end      
    end
        
    while i < new_array.size do
      j = i+1
      t = new_array[i]
      while j < new_array.size do
        if t!= nil && new_array[j] != nil
         if t.sequence > new_array[j].sequence
           t = new_array[j]
          end
        end      
        j+=1
      end
      i+=1
      if t!= nil
        fplates.push t.formplate
      end      
    end

    return fplates
  end
  
  def artificial_title()
    my_title = ""
    self.literals.each do |l|
      my_title += l.literal + "|"
    end
    return my_title
  end
  
  def get_or_create_custom_component(product_instance_id)
    res_list = CustomComponent.where ("component_id=" + self.id.to_s + " and product_instance_id=" + product_instance_id.to_s)
    if res_list.empty?
      cc = self.custom_components.new
      cc.component_id = self.id
      cc.product_instance_id = product_instance_id
      
      cc.custom_component_title = artificial_title
      cc.save
      return cc
    else
      cc = res_list.first
      return cc
    end
    
  end
  
  def get_attachments(product_instance)
    #return attachments that are contained within this custom_component
    if product_instance == nil
      return nil
    end
    
    cc = self.get_or_create_custom_component(product_instance.id)
    return cc.attachments
    
    
  end


  def create_hierarchy
    #first determine the sequence. assume this goes last in the sequence.
    #---get max componentheiracy for this parentcomponent
    if self.parent_component_id != nil
      my_seq = ComponentHierarchy.get_max_sequence(self.parent_component_id) + 1
      ComponentHierarchy.create(parent_component_id: self.parent_component_id, component_id: self.id, sequence: my_seq) if !self.parent_component.nil?
    end

  end


end
