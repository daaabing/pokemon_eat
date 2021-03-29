class Question < ApplicationRecord
    has_many :options, dependent: :destroy, inverse_of: :question
    def self.generate_question
      #Randomly select a question from Question.all
      question = Question.find_by_id(rand(1..Question.count))
    end

    def self.generate_response(ques_id, user_choice)
      #Generate the response based on the answer
      #replace the [] in the question.answer with the options.choice
      #input: question, choice
      #output: the response to display
      question = Question.find_by_id(ques_id)
      choice = Option.find_by(option: user_choice).choice.to_s
      answer = question.answer.to_s
      answer.gsub!("[]", choice)
    end
end
