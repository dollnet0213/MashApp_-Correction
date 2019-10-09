class User < ApplicationRecord
    has_secure_password
    validates :name,{presence: true}
    validates :image_name,{presence: true}
  def posts
    return Post.where(user_id: self.id)
  end
  
end
