# Create tenant
tenant = Tenant.create(
  site_name: 'Идеи для STATTECH',
  subdomain: 'default',
  status: 'active'
)
Current.tenant = tenant

# Create an admin user and confirm its email automatically
admin = User.create(
  full_name: 'Admin',
  email: 'admin@example.com',
  password: 'password',
  role: 'admin',
  confirmed_at: Time.zone.now
)

# Create some boards
feature_board = Board.create(
  name: 'Новые идеи',
  description: 'This is a **board**! You can create as many as you want from **site settings** and their description can be *Markdown formatted*.',
  order: 0
)
bug_board = Board.create(
  name: 'Отчеты об ошибках',
  description: 'Tell us everything about problems you encountered in our services!',
  order: 1
)

# Create some post statuses
planned_post_status = PostStatus.create(
  name: 'Запланировано',
  color: '#0096ff',
  order: 0,
  show_in_roadmap: true
)
in_progress_post_status = PostStatus.create(
  name: 'В прогрессе',
  color: '#9437ff',
  order: 1,
  show_in_roadmap: true
)
completed_post_status = PostStatus.create(
  name: 'Завершено',
  color: '#6ac47c',
  order: 2,
  show_in_roadmap: true
)
rejected_post_status = PostStatus.create(
  name: 'Отклонено',
  color: '#ff2600',
  order: 3,
  show_in_roadmap: false
)

# Create some posts
post1 = Post.create(
  title: 'Пользователи могут оставлять отзывы, публикуя сообщения!',
  description: 'You can assign a **status** to each post: this one, for example, is marked as "Planned". Remember that you can customise post statuses from Site settings > Statuses',
  board_id: feature_board.id,
  user_id: admin.id,
  post_status_id: planned_post_status.id
)
PostStatusChange.create(
  post_id: post1.id,
  user_id: admin.id,
  post_status_id: planned_post_status.id
)

post2 = Post.create(
  title: 'Есть несколько досок',
  description: 'For now you have Feature Requests and Bug Reports, but you can add or remove as many as you want! Just go to Site settings > Boards!',
  board_id: bug_board.id,
  user_id: admin.id
)

# # Create some comments
post1.comments.create(
  body: 'Users can comment to express their opinions! As with posts and board descriptions, comments can be *Markdown* **formatted**',
  user_id: admin.id
)

# Let the user know how to log in with admin account
puts "A default tenant has been created with name #{tenant.site_name}"
puts 'A default admin account has been created. Credentials:'
puts "-> email: #{admin.email}"
puts "-> password: #{admin.password}"
