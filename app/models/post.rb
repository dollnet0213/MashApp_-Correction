class Post < ApplicationRecord
    validates :title,{presence: true}
    validates :title,{length:{maximum: 40}}
    validates :content,{presence: true}
    validates :image_name,{presence: true}
  def user
    return User.find_by(id: self.user_id)
  end
  
end
