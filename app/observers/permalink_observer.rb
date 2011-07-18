# See http://stackoverflow.com/questions/1302022/best-way-to-generate-slugs-human-readable-ids-in-rails
class String
  def to_slug
    slug = self.strip
    slug.gsub! /['`]/, ''              # Remove apostrophes
    slug.gsub! /\s*@\s*/, " at "       # @ -> at
    slug.gsub! /\s*&\s*/, " and "      # & -> and
    slug.gsub! /\s*\W\s*/, '-'         # Replace nasty stuff with dashes
    slug.gsub! /-+/, '-'               # Merge multiple dashes
    slug.gsub! /\A[-_\.]+|[-_\.]+\z/, '' # Strip leading/trailing crap
    slug.downcase
  end
end


class PermalinkObserver < ActiveRecord::Observer
  observe :user, :category, :listing

  def before_create record
    record.permalink = generate_permalink_for record
  end

private
  # Generate a unqiue permalink with increasing indexes
  # Like 'bicycle', 'bicycle-1', 'bicycle-2', ...
  def generate_permalink_for record
    model      = record.class
    permalink  = record.send(model.class_variable_get :@@permalink_field).to_slug
    permalink += '-1' if reserved_permalink? permalink, model
    permalink  = permalink.next while reserved_permalink? permalink, model
    permalink
  end

  def reserved_permalink? permalink, model
    model.all.map(&:permalink).concat(RESERVED_PATHS).include? permalink
  end
end