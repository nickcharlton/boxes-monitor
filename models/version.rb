class Version < ActiveRecord::Base
  belongs_to :tool

  scope :latest, -> { order('version DESC').first }
end
