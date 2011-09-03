class RegistrationsController < Devise::RegistrationsController
  def create
    super
    if @user.email =~ /@uchicago.edu/ # Is this a strong enough regex?
      @user.roles = %w( seller )
      @user.save # I've always wondered, is there something to force the save so i don't have to call it seperately?
    end
end