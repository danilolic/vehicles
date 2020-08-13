# frozen_string_literal: true

module Api
  class ModelsController < ApplicationController
    before_action :authorize_access_request!, except: :index
    before_action :set_model, only: %i[show update destroy]
    before_action :set_brand, only: %i[index create]

    # GET api/brands/:brand_id/models
    def index
      @models = @brand.models.order(:name)

      render json: @models
    end

    # GET api/models/1
    def show
      render json: @model
    end

    # POST api/brands/:brand_id/models
    def create
      @model = @brand.models.build(model_params)

      if @model.save
        render json: @model, status: :created
      else
        render json: @model.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT api/models/1
    def update
      if @model.update(model_params)
        render json: @model
      else
        render json: @model.errors, status: :unprocessable_entity
      end
    end

    # DELETE api/models/1
    def destroy
      @model.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_model
      @model = Model.find(params[:id])
    end

    def set_brand
      @brand = Brand.find(params[:brand_id])
    end

    # Only allow a trusted parameter "white list" through.
    def model_params
      params.require(:model).permit(:name, :brand_id)
    end
  end
end
