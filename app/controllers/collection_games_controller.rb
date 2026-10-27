class CollectionGamesController < ApplicationController
  before_action :authenticate_user!

  def create
    game = Game.find(params[:game_id])
    collection = current_user.collections.find(params[:collection_id])

    collection_game = CollectionGame.find_or_initialize_by(
      collection: collection,
      game: game
    )

    collection_game.added_at ||= Time.current
    collection_game.save!

    redirect_to game_path(game), notice: "Игра добавлена в коллекцию"
  end

  def destroy
    collection_game = CollectionGame.find(params[:id])
    collection = current_user.collections.find(collection_game.collection_id)

    collection_game.destroy!

    redirect_to collection_path(collection), notice: "Игра удалена из коллекции"
  end
end