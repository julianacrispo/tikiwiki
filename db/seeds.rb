require 'faker'

5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save

end
users = User.all

# Create wikis
50.times do
  Wiki.create(
    subject:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
  )
end
wikis = Wiki.all

# Create posts
100.times do
  Post.create(
    body: Faker::Lorem.paragraph
  )
end




puts "Seed finished"
puts "#{Wiki.count} wikis created"
puts "#{Post.count} posts created"
