class Version < ActiveRecord::Base
  belongs_to :tool

  validates :version, presence: true

  scope :latest, -> { order('version DESC').first }
end
