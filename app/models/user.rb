class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :suggested_relations,
           class_name: "GameRelation",
           foreign_key: :created_by_user_id,
           dependent: :nullify

  def admin?
    role == "admin"
  end
end