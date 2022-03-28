class Api::V1::MandalsController < ApplicationController
  def index
    if params[:district_id].present?
      @district = District.find_by(id: params[:district_id])  
      @mandals = Mandal.where(district_id: params[:district_id]) if @district.present?
    else
      @mandals = Mandal.all
    end
    render
  end

end