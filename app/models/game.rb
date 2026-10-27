class Game < ApplicationRecord
     has_many :reviews, dependent: :destroy
     has_many :dlcs, dependent: :destroy
     has_many :offers, dependent: :destroy

     has_many :game_developers, dependent: :destroy
     has_many :developers, through: :game_developers

     has_many :game_publishers, dependent: :destroy
     has_many :publishers, through: :game_publishers

     has_many :game_genres, dependent: :destroy
     has_many :genres, through: :game_genres

     has_many :game_tags, dependent: :destroy
     has_many :tags, through: :game_tags

     has_many :game_platforms, dependent: :destroy
     has_many :platforms, through: :game_platforms

     has_many :collection_games, dependent: :destroy
     has_many :collections, through: :collection_games

     has_many :series_games, dependent: :destroy
     has_many :series, through: :series_games

     has_many :game_modes, dependent: :destroy
     has_many :modes, through: :game_modes
     validates :slug, uniqueness: true, allow_nil: true

     has_many :outgoing_relations,
          class_name: "GameRelation",
          foreign_key: :game_from_id,
          dependent: :destroy

     has_many :incoming_relations,
          class_name: "GameRelation",
          foreign_key: :game_to_id,
          dependent: :destroy
end
