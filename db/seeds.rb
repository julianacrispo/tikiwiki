require 'faker'

# Create Posts
50.times do
  Wiki.create(
    subject:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
  )
end
wikis = Wiki.all

# Create Comments
100.times do
  Post.create(
    body: Faker::Lorem.paragraph
  )
end

puts "Seed finished"
puts "#{Wiki.count} wikis created"
puts "#{Post.count} posts created"
