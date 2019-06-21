class Product < ApplicationRecord
    attr_accessor :jan
    validates :code, presence: true, uniqueness: true

end
