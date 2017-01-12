class Post < ActiveRecord::Base

  # CLICKBAIT_PATTERNS = [ "Won't Believe","Secret", "Top [0-9]*","Guess"]
  CLICKBAIT_PATTERNS = [/Won't Believe/i,/Secret/i,/Top [0-9]*/i,/Guess/i]

  validates :title , presence: true
  validates :content , length: {:minimum => 250 }
  validates :summary, length: { :maximum => 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
  validate :is_clickbait_title?
  def is_clickbait_title?
    flag=CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
    if flag
      errors.add(:title, "must be clickbait")
    end
  end
end
