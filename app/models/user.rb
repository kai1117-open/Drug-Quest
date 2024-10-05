class User < ApplicationRecord
  validates :name, {presence: true}
 validates :email, {presence: true, uniqueness: true}
 validates :password, {presence: true}

 def posts
  return Post.where(user_id: self.id)
end



has_one :score

has_many :likes
has_many :liked_posts, through: :likes, source: :post
has_secure_password

end
 