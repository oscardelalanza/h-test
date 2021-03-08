# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
owners = Owner.create([
                        { name: 'Jane Doe', available_day: 'Monday', hour_start: '08:00', hour_end: '14:00',
                          phone: '4445556666', password: '123456' },
                        { name: 'John Doe', available_day: 'Tuesday', hour_start: '09:00', hour_end: '12:00',
                          phone: '3335556666', password: '123456' },
                        { name: 'Jeanna Doe', available_day: 'Wednesday', hour_start: '12:00', hour_end: '15:00',
                          phone: '4448886666', password: '123456' }
                      ])
owners.each do |owner|
  owner.properties.create([
                            { name: "Property #{owner.name}", description: 'description random', status: 'published',
                              rental_price: 150.53 },
                            { name: "Property #{owner.name}", description: 'description random', status: 'available',
                              rental_price: 150.53 },
                            { name: "Property #{owner.name}", description: 'description random', status: 'deleted',
                              rental_price: 150.53 }
                          ])
end
