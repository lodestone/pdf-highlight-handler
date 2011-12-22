class PublicationsController < ApplicationController
  respond_to :xml, :html
  expose(:publication)
  expose(:publications)

  def create
    xml = params.keys.first
    publication, user, highlights = HighlightParser.parse(xml)
    respond_with publication
  end

end
