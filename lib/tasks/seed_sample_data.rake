namespace :seed_data do
  desc 'Generate data for test purpose'
  task generate: :environment do
    puts "#{Time.current}: start"

    ranges = [
      "00 - 04",
      "04 - 08",
      "08 - 12",
      "12 - 16",
      "16 - 20",
      "20 - 00"
    ]

    def match_index(index)
      case index
      when *[0..9]
        1
      when *[10..19]
        2
      when *[20..29]
        3
      when *[30..39]
        4
      when *[40..49]
        5
      when *[50..59]
        6
      end
    end

    games_hash = [
      {
        "name" => "Call of Duty: Warzone",
        "platforms" => "PS4, Xbox One, PC"
      },
      {
        "name" => "Fortnite",
        "platforms" => "PS4, Xbox One, Switch, PC"
      },
      {
        "name" => "Super Smash Bros. Ultimate",
        "platforms" => "Switch"
      },
      {
        "name" => "Rocket League",
        "platforms" => "PS4, Xbox One, Switch, PC"
      },
      {
        "name" => "Teamfight Tactics",
        "platforms" => "PC, Mobile"
      },
      {
        "name" => "Mario Kart 8 Deluxe",
        "platforms" => "Switch"
      },
      {
        "name" => "Apex Legends",
        "platforms" => "PS4, Xbox One, PC"
      },
      {
        "name" => "PlayerUnknown's Battlegrounds",
        "platforms" => "PS4, Xbox One, PC"
      },
      {
        "name" => "FIFA 20",
        "platforms" => "PS4, Xbox One, Switch, PC"
      },
      {
        "name" => "NBA 2K20",
        "platforms" => "PS4, Xbox One, Switch, PC"
      },
      {
        "name" => "Madden NFL 20",
        "platforms" => "PS4, Xbox One, PC"
      },
      {
        "name" => "Overwatch",
        "platforms" => "PS4, Xbox One, Switch, PC"
      },
      {
        "name" => "Animal Crossing: New Horizons",
        "platforms" => "Switch"
      },
      {
        "name" => "Overcooked 2",
        "platforms" => "PS4, Xbox One, Switch, PC"
      },
      {
        "name" => "Destiny 2: Shadowkeep",
        "platforms" => "PS4, Xbox One, PC"
      },
      {
        "name" => "Tom Clancy's Rainbox Six Siege",
        "platforms" => "PS4, Xbox One, PC"
      },
      {
        "name" => "World of Warcraft",
        "platforms" => "PC"
      },
      {
        "name" => "Mario Party",
        "platforms" => "Switch"
      },
      {
        "name" => "Sea of Thieves",
        "platforms" => "Xbox One, PC"
      },
      {
        "name" => "A Way Out",
        "platforms" => "PS4, Xbox One, PC"
      },
      {
        "name" => "Minecraft",
        "platforms" => "PS4, Xbox One, Switch, PC, Mobile"
      },
      {
        "name" => "Grand Theft Auto V",
        "platforms" => "PS4, Xbox One, PC"
      },
      {
        "name" => "Red Dead Redemption 2",
        "platforms" => "PS4, Xbox One, PC"
      },
      {
        "name" => "Borderlands 3",
        "platforms" => "PS4, Xbox One, PC"
      },
      {
        "name" => "Counter-Strike: Global Offensive",
        "platforms" => "PC"
      },
      {
        "name" => "iRacing",
        "platforms" => "PC"
      },
      {
        "name" => "Any Jackbox Party Pack",
        "platforms" => "PS4, Xbox One, Switch, PC, Mobile"
      },
      {
        "name" => "Mortal Kombat 11",
        "platforms" => "PS4, Xbox One, Switch, PC"
      },
      {
        "name" => "Street Fighter V: Champion Edition",
        "platforms" => "PS4, Xbox One, PC"
      },
      {
        "name" => "Final Fantasy XIV",
        "platforms" => "PS4, PC"
      },
      {
        "name" => "Magic: The Gathering Arena",
        "platforms" => "PC"
      },
      {
        "name" => "Halo: The Master Chief Collection",
        "platforms" => "Xbox One, PC"
      },
      {
        "name" => "The Division 2",
        "platforms" => "PS4, Xbox One, PC"
      }
    ]

    games_hash.each do |game_hash|
      platforms = game_hash["platforms"].split(", ")
      platforms.each do |platform_name|
        db_platform = Platform.find_by(name: platform_name)
        Game.create(name: game_hash["name"], platform_id: db_platform.id)
      end
    end

    60.times do |i|
      User.create(
        nickname: "test_#{i}",
        time_to_play: ranges[match_index(i) - 1],
        tg_id: 123123123,
        tg_first_name: "test_#{i}",
        tg_last_name: "test_#{i}",
        tg_username: "test_#{i}",
        games: [Game.find_by(id: (i + 1)) || Game.first],
        is_bot: false
      )
    end

    puts "#{Time.current}: finished"
  end
end
