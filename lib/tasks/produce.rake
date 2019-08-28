namespace :produce do
  desc "TODO"
  task outlines: :environment do
    list = File.open(Rails.root / 'outline_list.txt', 'r')

    count = 1
    list.each do |line|
      Outline.create(number: line[/\d+/], title: line.gsub!(/\d+/,"").strip!)
      count = count + 1
    end
  end

  task users: :environment do
    User.create(email: 'airblaster@example.com', password: 'password')
  end

  task list: :environment do
    rand(6..12).times do
      cong = Congregation.new
      cong.name = Faker::Address.community
      cong.save

      rand(3..20).times do
        speaker = cong.speakers.new

        speaker.first_name = Faker::Name.first_name
        speaker.last_name = Faker::Name.last_name
        speaker.email = Faker::Internet.email
        speaker.phone = Faker::PhoneNumber.cell_phone
        speaker.save

        rand(1..7).times do
          speaker.outlines << Outline.all.sample
        end
      end
    end

    rand(2..5).times do
      Group.create(name: Faker::Name.last_name)
    end
  end

end
