# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

reva = User.new(username: 'Reva', email: 'reva@test.com', password: '123456')
reva.save

reva_project = reva.projects.build(name: 'Better Meals', technologies: 'Ruby on Rails', duration: '1 month', description: 'ruby on rails project', github_link: 'some link')
reva_project.save

dada = User.new(username: 'Dada', email: 'dada@test.com', password: '123456')

dada_project = dada.projects.build(name: 'Build Together', technologies: 'React', duration: '1 month', description: 'react project', github_link: 'some link')
dada_project.save

c = Comment.new(title: "dada's comment", description: "dada dada dada")