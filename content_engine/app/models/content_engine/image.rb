module ContentEngine
  class Image < ApplicationRecord
    validates :filename, uniqueness: true
    validates :code, presence: true
    
    has_many :filetags, primary_key: 'filename', foreign_key: 'filename'
    def to_param
        filename
    end
  end
end
