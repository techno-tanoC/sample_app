namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
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

    users = User.find_by_sql("select * from users limit 6")
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each {|user| user.microposts.create!(content: content) }
    end
  end
end
