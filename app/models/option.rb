class Option < ApplicationRecord
    #one question entry -> multiple option entries.
    #It is a one to many mapping
    belongs_to :question, class_name: 'Question', foreign_key: 'question_id', inverse_of: :options
end
