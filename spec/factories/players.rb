# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :player do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
