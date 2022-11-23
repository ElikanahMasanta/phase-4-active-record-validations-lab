class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
    validate :title_is_clickbait?


    # constant within the class with the patterns, which is acccessed in a later 
    # method - this is an array of regex keys - only needs a Capital at the start
    # but convention seems to be to put it in all caps for clarity.
    CLICKBAIT_PATTERNS = [
        /Won't Believe/i,
        /Secret/i,
        /Top \d/i,
        /Guess/i
    ]

    def title_is_clickbait?
        # if title does not include x, y , z, then error out.
        if CLICKBAIT_PATTERNS.none? { |pattern| pattern.match title }
            errors.add(:title, "must be clickbait")
        end
    end 
    
end
