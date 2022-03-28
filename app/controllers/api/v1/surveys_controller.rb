class Api::V1::SurveysController < ApplicationController
  def index
    if params[:village_id].present?
      @village = Village.find_by(id: params[:village_id])
      @surveys = Survey.where(village_id: params[:village_id]) if @village.present?
    end
    render
  end
end