class Tool < ActiveRecord::Base
  has_many :versions

  validates :name, presence: true
end
