require 'rails_helper'
require 'simplecov'
SimpleCov.start


RSpec.describe Question, type: :model do
  context 'association test' do
    it 'creation and association' do
      ques = Question.create(question: 'Do you like supreman or batman?', answer: 'A [] appears behind you and says he wants to visit these restaurants~', question_type: 'choose')
      opt1 = Option.create(option: 'superman!', choice: 'superman', question: ques)
      opt2 = Option.create(option: 'batman!', choice: 'batman', question: ques)

      expect(ques.question).to eq('Do you like supreman or batman?')
      expect(opt1.question_id).to eq(ques.id)
      expect(opt2.question_id).to eq(ques.id)
      expect(opt1.question_id.nil?).to eq(false)
      expect(opt2.question_id.nil?).to eq(false)

      expect(ques.answer).to eq(opt1.question.answer)
      expect(ques.options.first).to eq(opt1)
    end

  end
end