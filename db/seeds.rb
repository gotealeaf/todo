# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

Todo.create(name: "cook dinner")
Todo.create(name: "eat")
Todo.create(name: "wash dishes")

User.create(username: "joe", full_name: "Joe Smith", email: "joe@example.com")
