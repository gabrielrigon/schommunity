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

State.create!([
    { name: 'São Paulo', initials: 'SP' },
    { name: 'Minas Gerais', initials: 'MG' }
  ])

City.create!([
    { name: 'Mogi Mirim', state_id: 1 },
    { name: 'Poços de Caldas', state_id: 2 }
  ])

Institution.create!([
    { name: 'Fatec', cnpj: 15457042000124 }
  ])

Address.create!([
    { street: 'Ariovaldo Silveira Franco', number: 1234, district: 'Jd. Patrícia',
      institution_id: 1, city_id: 1, state_id: 1, zipcode: '13800-700' }
  ])
