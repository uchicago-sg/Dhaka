class UserObserver < ActiveRecord::Observer
  def before_create record
    record.roles += %w( seller ) if record.email =~ /@(.+\.)*(uchicago\.edu|uchospitals\.edu|chicagobooth\.edu)\z/i
  end
end