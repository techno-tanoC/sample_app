namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end

  def make_users
    User.create!(name: "piyo",
                 email: "piyo@piyo.com",
                 password: "piyopiyo",
                 password_confirmation: "piyopiyo")
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n + 1}@railstutorial.jp"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end

  def make_microposts
    users = User.find_by_sql("select * from users limit 6")
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each {|user| user.microposts.create!(content: content) }
    end
  end

  def make_relationships
    users = User.all
    user = users.first
    followed_users = users[2..50]
    followers = users[4..40]
    followed_users.each {|followed| user.follow!(followed) }
    followers.each {|follower| follower.follow!(user) }
  end
end
