# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.count.zero?
  User.create! email: 'admin@mystand.ru', password: '123qwe123qwe', confirmed_at: Time.zone.now
end

if Tag.count.zero?
  tag_names = [:activism,
               :adventure,
               :art,
               :community,
               :doer,
               :"fitness&athletics",
               :learning,
               :music,
               :outdoors,
               :technology]

  tag_names.each do |tag_name|
    Tag.create title: tag_name
  end
end
