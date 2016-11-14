foo = User.create!({
  email: "foo@example.invalid",
  password: "xxxxxx",
  username: "therealfoo",
  handle: "Foo",
  id: 1001
})

require "securerandom"

foo.posts.create!(Array.new(30) {
  { body: SecureRandom.base64 }
})

foo.posts.create!([
  { body: "Making #posts on #my #website is #fun!" },
  { body: "Can't stop making #posts!" }
])

bar = User.create!({
  email: "bar@example.invalid",
  password: "xxxxxx",
  username: "xxbarxx",
  handle: "Bar",
  id: 1002
})

bar.follow(foo)

bar.posts.create!(
  { body: "Just followed @therealfoo!" }
)

foo.follow(bar)

foo.posts.create!(
  { body: "Just followed @xxbarxx back!" }
)

baz = User.create!({
  email: "baz@example.invalid",
  password: "xxxxxx",
  username: "__baz",
  handle: "Baz",
  id: 1003
})

baz.follow(foo)
baz.follow(bar)

baz.posts.create!(
  { body: "postsss!" }
)