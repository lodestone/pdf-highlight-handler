class PublicationsController < ApplicationController
  respond_to :xml, :html, :json
  expose(:publication) { Publication.find_by_uuid(params[:id]) }
  expose(:publications) { Publication.search(params).all }

  def create
    xml = request.raw_post
    publication, user, highlights = HighlightParser.parse(xml)
    
    if publication
      respond_to do |wants|
        wants.xml { render :xml => publication.to_xml(:methods => :popular_highlights), :status => 201 }
        # wants.xml { render :xml => publication.to_xml(:methods => :popular_highlights), :status => 201 }
        wants.html { render :xml => publication.to_xml(:methods => :popular_highlights), :status => 201 }
      end
      # respond_with publication, :status => 201
    else
      respond_to do |wants|
        wants.xml {  render :xml => 'Error', :status => 400 }
      end
    end
  end

  def index
  end

  def show
    respond_with publication
  end

end
