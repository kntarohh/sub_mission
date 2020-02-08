class Post < ApplicationRecord
  belongs_to :user
  has_many   :likes, dependent: :destroy
  has_many   :iine_users, through: :likes, source: :user
  has_many   :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :picture, presence: true
  validate  :picture_size
  
  def give_iine(user)
    likes.create(user_id: user.id)
  end

  def cancel_iine(user)
    likes.find_by(user_id: user.id).destroy
  end
  
  def iine?(user)
    iine_users.include?(user)
  end

  private

    def picture_size
      if picture.size > 3.megabytes
        errors.add(:picture, "should be less than 3MB")
      end
    end
end
