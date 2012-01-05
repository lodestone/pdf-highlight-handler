class PublicationsController < ApplicationController
  respond_to :xml, :html, :json
  expose(:publication) { Publication.find_by_uuid(params[:id]) }
  expose(:publications) { Publication.search(params).all }

  def create
    xml = request.raw_post
    publication, user, highlights = HighlightParser.parse(xml)
    if publication
      respond_to do |wants|
        wants.xml  { render :xml => publication.to_xml, :status => 201 }
        wants.json { render :xml => publication.to_json, :status => 201 }
        # Default to xml
        wants.html { render :xml => publication.to_xml, :status => 201 }
      end
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
