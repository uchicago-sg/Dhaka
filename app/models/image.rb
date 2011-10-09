class Image < ActiveRecord::Base
  belongs_to :listing
  has_attached_file :photo, :styles => {
    :large => "640x480",
    :small => "200x200#",
    :thumb => "100x100#"
  }
  validates_attachment_size :photo, :less_than => 3.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
end