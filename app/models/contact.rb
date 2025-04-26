class Contact < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }

    has_many :notes, dependent: :destroy

    belongs_to :user
    
    accepts_nested_attributes_for :notes
end
