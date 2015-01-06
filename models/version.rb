class Version < ActiveRecord::Base
  belongs_to :tool

  scope :latest, -> { order('created_at DESC').first }
end
