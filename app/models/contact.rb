class Contact < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }

    has_many :notes, dependent: :destroy
    accepts_nested_attributes_for :notes, allow_destroy: true

    belongs_to :user
end
