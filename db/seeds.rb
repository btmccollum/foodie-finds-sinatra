User.create(username: "test01", password: "12345", email: "test1@test.com")
User.create(username: "test02", password: "12345", email: "test2@test.com")
User.create(username: "test03", password: "12345", email: "test3@test.com")
User.create(username: "test04", password: "12345", email: "test4@test.com")
User.create(username: "test05", password: "12345", email: "test5@test.com")

tx = State.new(name: "Texas")
tx.save
dallas = City.create(name: "Dallas")
dallas.update(:state_id => 1)
ftw = City.create(name: "Fort Worth")
ftw.update(:state_id => 1)

posts_list = {
    1 => {
        :title => "Found amazing cookies in the West End",
        :content => "If you love some unique cookies, you need to try these Strawberry Rhubarb sugar cookies at Joes!",
        :location => "Joe's Corner",
        :city_id => 1,
        :score => 0
    },
    2 => {
        :title => "BEST.SUSHI.EVER.",
        :content => "Their spicy tuna rolls are AMAZING, try them next time you go.",
        :location => "Central Market",
        :city_id => 2
    },
    3 => {
        :title => "Pepper X Salsa!",
        :content => "Central started carrying the Hot Ones last dab sauce!! A bit pricey at $20, but so hot!",
        :location => "Central Market",
        :city_id => 2,
        :score => 0
    },
    4 => {
        :title => "Peking Duck Tacos",
        :content => "Just came across a street vendor selling peking duck tacos, they are simply amazing. They taste just like the peking duck I had in Beijing.",
        :location => "Corner of Knox and M Street",
        :city_id => 1,
        :score => 0
    },
    2 => {
        :title => "Best Sushi 2.0",
        :content => "I know i just posted about Central's Sushi, but we went to PS for dinner and WOW! That California Roll was life changing.",
        :location => "Pacific Table",
        :city_id => 2,
        :score => 0
    }
}

posts_list.each do |user, hash|
    post = Post.new
    post.user_id = user
    hash.each do |attribute, value|
        post[attribute] = value
    end
    post.save
end

# create_table :comments do |t|
#     t.string :content
#     t.integer :score
#     t.integer :user_id
#     t.timestamps null:true
#   end

comments_list = {
    1 => {
        :content => "Wow that does sound good, did they have any other unique types of cookies??",
        :post_id => 1,
        :score => 10
    },
    2 => {
        :content => "YUM! Strawberry Rhubarb is one of my favorite things ever, trying these today!",
        :post_id => 1,
        :score => 0
    },
    3 => {
        :content => "I'll have to check those out, I've been looking for authentic peking duck, does it come with plum sauce??",
        :post_id => 4,
        :score => 2
    },
    4 => {
        :content => "What was the craziest one they had?",
        :post_id => 1,
        :score => 0
    }
}

comments_list.each do |user, hash|
    comment = Comment.new
    comment.user_id = user
    hash.each do |attribute, value|
        comment[attribute] = value
    end
    comment.save
end