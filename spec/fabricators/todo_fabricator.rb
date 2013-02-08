Fabricator(:todo) do
  name { Faker::Loren.words(5).join(" ") }
  user
end

Fabricator(:user) do
  email { Faker::Internet.email }
end
