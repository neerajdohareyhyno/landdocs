class Api::V1::VillagesController < ApplicationController
  def index
    if params[:mandal_id].present?
      @mandal = Mandal.find_by(id: params[:mandal_id])  
      @villages = Village.where(mandal_id: params[:mandal_id]) if @mandal.present?
    else
      @villages = Village.all
    end
    render
  end

  def search
    if params[:query].present?
      like_keyword = "%#{params[:query]}%"
      @villages = Village.where('name ILIKE ?', like_keyword)
    end
    render
  end
end