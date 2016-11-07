foo = User.create({
  email: "foo@example.invalid",
  password: "foobar",
  username: "therealfoo",
  handle: "Foo Bar"
})

foo.posts.create({
  body: "Making #posts on #my #website is #fun!"
})

foo.posts.create({
  body: "Can't stop making #posts!"
})