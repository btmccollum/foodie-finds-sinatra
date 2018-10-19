User.create(username: "test01", password: "12345", email: "test1@test.com")
User.create(username: "test02", password: "12345", email: "test2@test.com")
User.create(username: "test03", password: "12345", email: "test3@test.com")
User.create(username: "test04", password: "12345", email: "test4@test.com")
User.create(username: "test05", password: "12345", email: "test5@test.com")

states = ['Alabama','Alaska','Arizona','Arkansas','California','Colorado','Connecticut','Delaware','D.C.','Florida','Georgia','Hawaii','Idaho','Illinois','Indiana','Iowa','Kansas','Kentucky','Louisiana','Maine','Maryland','Massachusetts','Michigan','Minnesota','Mississippi','Missouri','Montana','Nebraska','Nevada','New Hampshire','New Jersey','New Mexico','New York','North Carolina','North Dakota','Ohio','Oklahoma','Oregon','Pennsylvania','Rhode Island','South Carolina','South Dakota','Tennessee','Texas','Utah','Vermont','Virginia','Washington','West Virginia','Wisconsin','Wyoming']

states.each do |category|
    new_category = Category.new(title: "#{category.downcase}")
    new_category.save
end

posts_list = {
    1 => {
        :title => "Found amazing cookies in the West End",
        :city => "Fort Worth",
        :content => "If you love some unique cookies, you need to try these Strawberry Rhubarb sugar cookies at Joes!",
        :location => "Joe's Corner",
        :score => 0,
        :category_id => 44
    },
    3 => {
        :title => "Pepper X Salsa!",
        :city => "Dallas",
        :content => "Central started carrying the Hot Ones last dab sauce!! A bit pricey at $20, but so hot!",
        :location => "Central Market",
        :score => 0,
        :category_id => 44
    },
    4 => {
        :title => "Peking Duck Tacos",
        :city => "Houston",
        :content => "Just came across a street vendor selling peking duck tacos, they are simply amazing. They taste just like the peking duck I had in Beijing.",
        :location => "Corner of Knox and M Street",
        :score => 0,
        :category_id => 44
    },
    2 => {
        :title => "Best Sushi 2.0",
        :city => "Fort Worth",
        :content => "I know i just posted about Central's Sushi, but we went to PS for dinner and WOW! That California Roll was life changing.",
        :location => "Pacific Table",
        :score => 0,
        :category_id => 44
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
        :post_id => 3,
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