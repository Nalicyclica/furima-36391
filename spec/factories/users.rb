FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end

    nickname { Faker::Artist.name }
    email { Faker::Internet.free_email }
    password { "#{Faker::Internet.password(min_length: 4)}1a" }
    password_confirmation { password }
    family_name { person.last.kanji }
    given_name { person.first.kanji }
    family_reading { person.last.katakana }
    given_reading { person.first.katakana }
    birthday { Faker::Date.between(from: '1930-01-01', to: 5.year.ago) }
  end
end
