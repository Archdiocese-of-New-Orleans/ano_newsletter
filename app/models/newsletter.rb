class Newsletter < ActiveRecord::Base

  has_attached_file :asset
  validates_attachment_content_type :asset, :content_type => /^application\//, :message => 'file type is not allowed'

  validates_attachment_presence :asset
  validates_presence_of :released_at

  scope :archive, ->{
    where("released_at <= ?", DateTime.now).order(released_at: :desc)
  }

  def pretty_date
    released_at.strftime("%b %e %Y")
  end

  if defined? rails_admin
    rails_admin do
      navigation_label "Media"
      include_all_fields
    end
  end

end
