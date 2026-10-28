class Post < ApplicationRecord
  STATUSES = %w[draft review published].freeze

  belongs_to :user
  has_one_attached :cover

  validates :title, presence: { message: "заголовок" }
  validates :body, presence: { message: "текст" }
  validates :status, inclusion: { in: STATUSES, message: "статус" }
  validate :acceptable_cover

  private

  def acceptable_cover
    return unless cover.attached?

    unless %w[image/jpeg image/png image/webp].include?(cover.blob.content_type)
      errors.add(:cover, "JPG, PNG или WEBP")
    end

    if cover.blob.byte_size > 10.megabytes
      errors.add(:cover, "не больше 10 МБ")
    end
  end
end