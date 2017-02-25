# defaults

Gender.create!([
    { name: 'Masculino', alias: 'male' },
    { name: 'Feminino', alias: 'female' }
  ])

UserType.create!([
    { name: 'Administrador', alias: 'admin' },
    { name: 'Diretor', alias: 'schoolmaster' },
    { name: 'Coordenador', alias: 'coordinator' },
    { name: 'Professor', alias: 'teacher' },
    { name: 'Representante de Classe', alias: 'representant' },
    { name: 'Aluno', alias: 'student' }
  ])

# data

Institution.create!([
    { trading_name: 'Fatec Mogi Mirim', company_name: 'Faculdade de Tecnologia Arthur de Azevedo', cnpj: '15.457.042/0001-24' }
  ])

State.create!([
    { name: 'São Paulo', initials: 'SP' },
    { name: 'Minas Gerais', initials: 'MG' }
  ])

City.create!([
    { name: 'Mogi Mirim', state_id: 1 },
    { name: 'Poços de Caldas', state_id: 2 }
  ])

Address.create!([
    { street: 'Rua Ariovaldo Silveira Franco', number: 1234, district: 'Jd. Patrícia',
      city_id: 1, state_id: 1, zipcode: '13800-700', linkable_type: User, linkable_id: 1 },
    { street: 'Rua Ariovaldo Silveira Franco', number: 1234, district: 'Jd. Patrícia',
      city_id: 1, state_id: 1, zipcode: '13800-700', linkable_type: Institution, linkable_id: 1 },
  ])

User.create!(first_name: '',
             last_name: '',
             phone: '',
             cpf: '',
             email: 'admin@admin.com',
             password: 'qwerty123',
             password_confirmation: 'qwerty123',
             gender_id: 1,
             user_type_id: 1
             )
