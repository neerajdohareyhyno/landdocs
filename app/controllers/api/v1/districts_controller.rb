class Api::V1::DistrictsController < ApplicationController
  def index
    @districts = District.all
    render
  end
end