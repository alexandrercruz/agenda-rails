namespace :utils do
  desc "Populate database."
  task seed: :environment do
    puts "Generate contacts..."
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        kind: Kind.all.sample,
        rmk: LeroleroGenerator.sentence([1,2,3,4,5].sample)
      )
    end
    puts "Generate contacts... [OK]"

    puts "Generate addresses and phones..."
    Contact.all.each do |contact|
      Address.create!(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state_abbr,
        contact: contact
      )
      Random.rand(1..5).times do |i|
        Phone.create!(
          phone: Faker::PhoneNumber.cell_phone,
          contact: contact
        )
      end
    end
    puts "Generate addresses and phones... [OK]"
  end
end
