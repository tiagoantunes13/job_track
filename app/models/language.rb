class Language < ApplicationRecord
  belongs_to :user

  enum :proficiency, { beginner: 0, intermediate: 1, advanced: 2, fluent: 3, native: 4 }
end
