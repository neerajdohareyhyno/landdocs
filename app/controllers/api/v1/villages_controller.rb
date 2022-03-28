class Api::V1::VillagesController < ApplicationController
  def index
    if params[:mandal_id].present?
      @mandal = Mandal.find_by(id: params[:mandal_id])  
      @villages = Village.where(mandal_id: params[:mandal_id]) if @mandal.present?
    elsif params[:search].present?
      like_keyword = "%#{params[:search]}%"
      @villages = Village.where('name ILIKE ?', like_keyword)
    else
      @villages = Village.all
    end
    render
  end
end