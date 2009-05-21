class Card < ActiveRecord::Base
    has_attached_file :cover,
                      :default_url=>"/images/defaultcard.jpg",
                      :styles => { 
                                   :A6  =>"297x419#",
                                   :medium => "300x300>",
                                   :thumb => "100x100#" }
    validates_attachment_content_type(:cover,:content_type => ["image/jpeg", "image/png", "image/gif"],:message => "Oops! Make sure you are uploading an image file."  )                                      
    
    has_attached_file :back,
                      :default_url=>"/images/defaultcard.jpg",
                      :styles => { 
                                   :A6  =>"297x419#",
                                   :medium => "300x300>",
                                   :thumb => "100x100#" }
    validates_attachment_content_type(:back,:content_type => ["image/jpeg", "image/png", "image/gif"],:message => "Oops! Make sure you are uploading an image file."  )                                      
    
    
                                   
    acts_as_taggable_on :tags                                  
    belongs_to :category
    belongs_to :user
    acts_as_commentable
    
    cattr_reader :per_page
    @@per_page=5
end
  