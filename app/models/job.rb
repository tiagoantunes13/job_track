class Job < ApplicationRecord
  has_many :job_applications, dependent: :destroy
  has_many :apply_links, dependent: :destroy
end