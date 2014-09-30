module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug
    class_attribute :slug_column
  end

  def to_param
    self.slug
  end

  def generate_slug
    the_slug = self.send(self.class.slug_column)
    self.slug = the_slug.parameterize
    
    if self.class == Post
      append_suffix
    end
  end

  def append_suffix
    self.slug += "-" + SecureRandom.urlsafe_base64(6)
  end

  module ClassMethods
    def sluggable_column(column_name)
      self.slug_column = column_name
    end
  end
end