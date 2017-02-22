# defaults

UserType.create!([
  { name: 'Administrador', alias: 'admin' },
  { name: 'Professor', alias: 'teacher' },
  { name: 'Aluno', alias: 'student' }
])

# data

User.create!(email: 'admin@admin.com',
             password: 'qwerty123',
             password_confirmation: 'qwerty123',
             user_type_id: 1)
