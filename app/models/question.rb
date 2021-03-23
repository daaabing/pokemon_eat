class Question < ApplicationRecord
    has_many :options, dependent: :destroy, inverse_of: :question
end
