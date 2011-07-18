class VersionsController < ApplicationController
  # GET /versions/:id/revert
  def revert
    @version = Version.find params[:id]
    @version.reify.save!
    redirect_to :back, :notice => "Undid #{@version.event}"
  end
end