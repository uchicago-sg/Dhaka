class PermalinkObserver < ActiveRecord::Observer
  observe :user, :category, :listing

  def before_create record
    record.permalink = reserve_permalink record
  end

private
  # Generate a unqiue permalink with increasing indexes
  # Like 'bicycle', 'bicycle-1', 'bicycle-2', ...
  def reserve_permalink record
    model = record.class
    field = model.class_variable_get :@@permalink_field
    raise "Object '#{record}' is not a #{model}"    unless record.is_a? model
    raise "#{model} does not respond to '#{field}'" unless record.respond_to? field

    permalink  = record.send(field).parameterize
    permalink += '-1' if reserved_permalink? permalink, model
    permalink  = permalink.next while reserved_permalink? permalink, model
    permalink
  end

  def reserved_permalink? permalink, model
    model.all.map(&:permalink).include? permalink
  end
end
