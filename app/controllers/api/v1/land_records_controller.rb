class Api::V1::LandRecordsController < ApplicationController
  def index
    if params[:village_id].present? && params[:survey_id].present?
      @land_record = LandRecord.includes(:survey).find_by(survey_id: params[:survey_id], survey: { village_id: params[:village_id] })
    elsif params[:village_id].present? && params[:khata_no].present?
      @land_record = LandRecord.includes(:survey).find_by(surveys:{ village_id: params[:village_id], khata_no: params[:khata_no]})
    end
    render
  end

  def get_khata_no
    if params[:village_id].present? && params[:survey_id].present?
      @survey = Survey.find_by(village_id: params[:village_id], id: params[:survey_id])
    end
    render
  end


end