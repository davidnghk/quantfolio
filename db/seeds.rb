# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'AMEX.csv'))
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  v = Vehicle.new
  v.ticker = row['Symbol']
  v.name = row['name']
  v.save
  puts "#{v.ticker}, #{v.name} saved"
end

puts "There are now #{Transaction.count} rows in the transactions table"