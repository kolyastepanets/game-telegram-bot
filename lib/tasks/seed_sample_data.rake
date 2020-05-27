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

    40.times do |i|
      Game.create(
        name: "test_#{i}",
        platform_id: match_index(i)
      )
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
