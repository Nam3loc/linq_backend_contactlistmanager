class User < ApplicationRecord
    has_secure_password
    
    has_many :contacts, dependent: :destroy
  end
  