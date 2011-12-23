class PublicationsController < ApplicationController
  respond_to :xml, :html
  expose(:publication) { Publication.find_by_uuid(params[:id]) }
  expose(:publications) { Publication.where(:title => /#{params[:q]}/).all }

  def create
    xml = request.raw_post
    publication, user, highlights = HighlightParser.parse(xml)
    
    if publication
      render :xml => publication, :status => 201
    else
      respond_to do |wants|
        wants.xml {  render :xml => 'Error', :status => 400 }
      end
    end
  end

  def index
  end

  def show
  end

end
