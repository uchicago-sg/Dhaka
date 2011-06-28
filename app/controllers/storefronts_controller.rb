class StorefrontsController < ApplicationController
  respond_to :html, :json
  load_and_authorize_resource
end