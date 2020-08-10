# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  enum role: { client: 0, admin: 1 }

  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :role, presence: true
end
