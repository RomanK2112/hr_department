admin = User.create_with(
  first_name: 'John',
  last_name: 'Doe',
  password: 'Test1234!',
  is_admin: true
).find_or_create_by(email: 'john@gmail.com')

employee1 = User.create(
  first_name: 'Bob',
  last_name: 'Worker',
  password: 'New1234!'
).find_or_create_by(email: 'bob@gmail.com')

employee2 = User.create(
  first_name: 'Jack',
  last_name: 'Programmer',
  password: 'New1234!'
).find_or_create_by(email: 'jack@gmail.com')

post1 = admin.posts.create(
  title: 'New post for rubyists',
  body: 'Here some useful links to articles'
)

post2 = admin.posts.create(
  title: 'Best practices for building API',
  body: "You'll find usefull info on these links"
)

group1 = Group.create(name: 'Ruby team', description: 'Rails developers')
group2 = Group.create(name: 'Golang team', description: 'Golang developers')

group1.posts << post1
group2.posts << post1

group1.posts << post2
group2.posts << post2
