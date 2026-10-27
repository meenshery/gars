require "csv"

GAMES_CSV_PATH = Rails.root.join("db", "seeds", "games_db.csv")

def seed
  reset_db

  create_admin
  create_games
end


def reset_db
  Rake::Task["db:drop"].invoke
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke
end


def create_admin
  User.create!(
    username: "admin",
    email: "gars@gmail.com",
    password: "testtest",
    role: "admin"
  )
end


def create_games
  CSV.foreach(
    GAMES_CSV_PATH,
    headers: true,
    encoding: "bom|utf-8"
  ) do |row|
    next unless parse_boolean(row["ready_for_seed"])

    create_game(row)
  end
end


def create_game(row)
  game = Game.create!(
    slug: row["key"],
    title: row["title"],
    description: row["description"],
    release_date: parse_date(row["release_date"]),
    age_rating: blank_to_nil(row["age_rating"]),
    playtime_min: parse_integer(row["playtime_min"]),
    playtime_max: parse_integer(row["playtime_max"]),
    difficulty: blank_to_nil(row["difficulty"]),
    session_length: row["session_length"],
    has_russian: parse_boolean(row["has_russian"]),
    cover_filename: blank_to_nil(row["cover_filename"])
  )

  create_named_relations(game.modes, row["game_modes"], Mode)
  create_named_relations(game.genres, row["genres"], Genre)
  create_named_relations(game.tags, row["tags"], Tag)
  create_named_relations(game.developers, row["developers"], Developer)
  create_named_relations(game.publishers, row["publishers"], Publisher)

  create_game_platforms(game, row["platforms"])
  create_game_series(game, row["series"], row["series_order"])
  create_game_dlcs(game, row["dlc"])
  create_game_offer(game, row)
end


def create_named_relations(collection, value, model)
  split_values(value).each do |name|
    record = model.find_or_create_by!(
      name: name
    )

    collection << record
  end
end


def create_game_platforms(game, value)
  split_values(value).each do |name|
    platform = Platform.find_or_create_by!(
      name: name
    )

    GamePlatform.create!(
      game: game,
      platform: platform,
      available: true
    )
  end
end


def create_game_series(game, series_title, series_order)
  title = blank_to_nil(series_title)

  return if title.nil?

  series = Series.find_or_create_by!(
    title: title
  )

  SeriesGame.create!(
    game: game,
    series: series,
    order_number: parse_integer(series_order)
  )
end


def create_game_dlcs(game, value)
  split_values(value, separator: ";").each do |title|
    Dlc.create!(
      game: game,
      title: title
    )
  end
end


def create_game_offer(game, row)
  store_name = blank_to_nil(
    row["primary_store"]
  )

  return if store_name.nil?

  store = Store.find_or_create_by!(
    name: store_name
  )

  offer = Offer.create!(
    game: game,
    store: store,
    price: normalize_decimal(row["current_price"]),
    currency: blank_to_nil(row["currency"]),
    region: blank_to_nil(row["region"]),
    url: blank_to_nil(row["store_url"]),
    available: available_in_russia?(row["region"]),
    checked_at: parse_datetime(row["price_checked_at"])
  )

  create_price_history(
    offer,
    row["price_history"]
  )
end


def create_price_history(offer, value)
  split_values(value, separator: ";").each do |entry|
    date_value, price_value = entry.split("|", 2)

    PriceHistory.create!(
      offer: offer,
      recorded_at: parse_datetime(date_value),
      price: normalize_decimal(price_value)
    )
  end
end


def available_in_russia?(region)
  region.to_s.strip != "NOT_RU"
end


def split_values(value, separator: ",")
  return [] if value.blank?

  value
    .split(separator)
    .map(&:strip)
    .reject(&:blank?)
    .uniq
end


def blank_to_nil(value)
  return nil if value.blank?

  value.strip
end


def parse_integer(value)
  return nil if value.blank?

  value.to_i
end


def normalize_decimal(value)
  return nil if value.blank?

  value
    .to_s
    .strip
    .tr(",", ".")
end


def parse_boolean(value)
  value
    .to_s
    .strip
    .casecmp?("yes")
end


def parse_date(value)
  return nil if value.blank?

  Date.parse(value)
end


def parse_datetime(value)
  return nil if value.blank?

  Time.zone.parse(value)
end


seed