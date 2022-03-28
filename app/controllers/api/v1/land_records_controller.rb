class Api::V1::LandRecordsController < ApplicationController
  def index
    if params[:village_id].present? && params[:survey_no].present?
      @land_record = LandRecord.includes(:survey).where(survey_id: params[:survey_no], survey: { village_id: params[:village_id] })
    elsif params[:village_id].present? && params[:khata_no].present?
      @land_record = LandRecord.includes(:survey).where(surveys:{ village_id: params[:village_id], khata_no: params[:khata_no]})
    end
    render
  end

  def get_khata_no
    if params[:village_id].present? && params[:survey_no].present?
      @survey = Survey.find_by(village_id: params[:village_id], survey_no: params[:survey_no])
    end
    render
  end


end