module Admin
  class GamesController < BaseController
    def index
      authorize! :read, Game

      @genres = Genre.order(:name)
      @platforms = Platform.order(:name)
      @tags = Tag.order(:name)

      @games = Game
        .preload(:genres, :tags, :platforms)
        .order(:title)

      filter_by_search
      filter_by_genre
      filter_by_platform
      filter_by_tag

      @games = @games.distinct
    end

    private

    def filter_by_search
      return if params[:query].blank?

      query = ActiveRecord::Base.sanitize_sql_like(params[:query].downcase)

      @games = @games.where(
        "LOWER(games.title) LIKE :query OR LOWER(games.slug) LIKE :query",
        query: "%#{query}%"
      )
    end

    def filter_by_genre
      return if params[:genre_id].blank?

      @games = @games
        .joins(:genres)
        .where(genres: { id: params[:genre_id] })
    end

    def filter_by_platform
      return if params[:platform_id].blank?

      @games = @games
        .joins(:platforms)
        .where(platforms: { id: params[:platform_id] })
    end

    def filter_by_tag
      return if params[:tag_id].blank?

      @games = @games
        .joins(:tags)
        .where(tags: { id: params[:tag_id] })
    end
  end
end