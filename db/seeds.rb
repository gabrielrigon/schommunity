# defaults

Gender.create!([
    { name: 'Masculino', alias: 'male' },
    { name: 'Feminino', alias: 'female' },
    { name: 'Outro', alias: 'other' }
  ])

UserType.create!([
    { name: 'Administrador', alias: 'admin' },
    { name: 'Diretor', alias: 'schoolmaster' },
    { name: 'Professor', alias: 'teacher' },
    { name: 'Aluno', alias: 'student' }
  ])

ClassroomTime.create!([
    { name: 'Manhã', initial: 'M', alias: 'morning' },
    { name: 'Noite', initial: 'N', alias: 'night' }
  ])

PostType.create!([
    { name: 'Dúvida', alias: 'question' },
    { name: 'Informação', alias: 'information' },
    { name: 'Material', alias: 'material' }
  ])

# data

State.create!([
    { name: 'São Paulo', initials: 'SP' },
    { name: 'Minas Gerais', initials: 'MG' }
  ])

City.create!([
    { name: 'Mogi Mirim', state_id: 1 },
    { name: 'Mogi Guaçu', state_id: 1 },
    { name: 'Itapira', state_id: 1 },
    { name: 'Poços de Caldas', state_id: 2 },
    { name: 'Jacutinga', state_id: 2 }
  ])

institution = Institution.new(trading_name: 'Administration')
institution.save(validate: false)

user = User.new(first_name: 'Administrador',
                last_name: '',
                phone: '',
                cpf: '000.000.000-00',
                email: 'admin@admin.com',
                password: 'qwerty',
                password_confirmation: 'qwerty',
                gender_id: 1,
                institution_id: 1,
                user_type_id: 1)

user.save(validate: false)
