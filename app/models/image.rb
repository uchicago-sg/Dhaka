class Image < ActiveRecord::Base
  belongs_to :listing
  has_attached_file :photo, :styles => {:large => "640x480", :small => "200x200#", :thumb => "100x100#"}
end