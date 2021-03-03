# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = User.create([
    {email: "zhengchuan000@gmail.com", password_digest: "1"},
    {email: "807442894@qq.com", password_digest: "1"},
    {email: "hzwang@ucdavis.edu", password_digest: "1"},
    {email: "heyunong1223@gmail.com", password_digest: "1"},
])
