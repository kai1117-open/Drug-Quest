class Post < ApplicationRecord
  validates :comment, {presence: true, length: { maximum: 140 }}
  validates:user_id,{presence:true}

  def user
    return User.find_by(id: self.user_id)
  end

  paginates_per 5


  belongs_to :user
  has_many :likes
end
 