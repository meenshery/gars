class Feedback < ApplicationRecord
  before_validation :normalize_body

  validates :body,
    presence: { message: "Введите сообщение" },
    length: {
      maximum: 2000,
      message: "Не больше 2000 символов"
    }

  private

  def normalize_body
    self.body = body.to_s.strip
  end
end