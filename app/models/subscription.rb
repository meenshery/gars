class Subscription < ApplicationRecord
  EMAIL_FORMAT = /\A[^\s@]+@[^\s@]+\.[^\s@]+\z/

  before_validation :normalize_email

  validates :email,
    presence: { message: "Введите email" },
    format: {
      with: EMAIL_FORMAT,
      message: "Проверьте email",
      allow_blank: true
    },
    uniqueness: {
      case_sensitive: false,
      message: "Вы уже подписаны",
      allow_blank: true
    }

  validates :personal_data_consent,
    acceptance: {
      message: "Подтвердите согласие на обработку данных",
      allow_nil: false
    }

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end