# frozen_string_literal: true

module Api
  class RefreshesController < ApplicationController
    before_action :authorize_refresh_request!

    def create
      session = JWTSessions::Session.new(payload: create_payload)
      render json: session.refresh(found_token)
    end

    private

    def create_payload
      payload.merge({ user_id: params[:user_id] })
    end
  end
end
