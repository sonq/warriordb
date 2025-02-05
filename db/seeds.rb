# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# db/seeds.rb
event_statuses = [ 'Taslak', 'Yayında', 'Devam Ediyor', 'Tamamlandı', 'İptal Edildi' ]

event_statuses.each do |status|
  EventStatus.find_or_create_by!(name: status)
end

# db/seeds.rb
beklemede = EventApplicationStatus.find_or_create_by!(name: 'Onay Bekliyor') do |status|
  status.is_default = true
end

[ 'Onaylandı', 'Reddedildi' ].each do |name|
  EventApplicationStatus.find_or_create_by!(name: name)
end

# db/seeds.rb
[ 'Bay', 'Bayan' ].each do |name|
  Gender.find_or_create_by!(name: name)
end


# db/seeds.rb
division_statuses = [ 'Taslak', 'Aktif', 'Tamamlandı' ]

division_statuses.each do |status|
  DivisionStatus.find_or_create_by!(name: status)
end
