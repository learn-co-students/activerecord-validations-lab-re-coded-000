class Post < ActiveRecord::Base
  CB = [  /Won't Believe/,  /Winner/i,  /click/i]
  validates :title, presence: true
  validates  :content , length: {minimum: 10}
  validates  :summary , length: {maximum: 10}
  validates :category, inclusion: { in: %w(Fiction),  message: "%{value} is not a valid category" }
  validate :is_valid_clickbait?
  def is_valid_clickbait?
    if CB.none? { |e| e.match(self.title) }
      errors.add(:title, "Invalid clickbait")
    end

  end
end
