Fabricator(:todo) do
  name { Faker::Lorem.words(5).join(" ") }
end
