# frozen_string_literal: true

module Api
  class SessionsController < ApplicationController
    def create
      @user = User.find_by!(email: params[:email])
      if @user.authenticate(params[:password])
        @session = JWTSessions::Session.new(payload: create_payload(@user))
        render json: @session.login, status: :created
      else
        render json: 'Invalid user', status: :unauthorized
      end
    end

    private

    def create_payload(user)
      { user_id: user.id, role: user.role }
    end
  end
end
