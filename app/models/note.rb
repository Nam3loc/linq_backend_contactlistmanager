class Note < ApplicationRecord
    belongs_to :contact, optional: true
  end
  