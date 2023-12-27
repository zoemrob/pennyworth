# id: id
# email: varchar
# password: varchar (hashed)
# first_name: varchar
# last_name: varchar
# phone: varchar
# created_at: datetime(6)
# updated_at: datetime(6)
class User < ApplicationRecord
  has_many :news, dependent: :destroy
end
