class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  validates :name, presence: true, uniqueness: true
  mount_uploader :photo, PhotoUploader
  include RailsSortable::Model
  set_sortable :sort  # indicate sort column
  # If you do not want timestamps to be updated on sorting, use following option.
  # set_sortable :sort, silence_recording_timestamps: true
end
