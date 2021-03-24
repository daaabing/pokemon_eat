class Option < ApplicationRecord
    belongs_to :question, class_name: 'Question', foreign_key: 'question_id', inverse_of: :options
end
