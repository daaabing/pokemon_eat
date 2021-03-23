require 'rails_helper'
require 'simplecov'
SimpleCov.start


RSpec.describe Question, type: :model do
  context 'association test' do
    it 'create question and option' do
      ques = Question.create!(question: 'haha', answer: 'hahaha', question_type: 'choose')
      opt = Option.create!(option: '?', choice: '??', question: ques)
      expect(ques.question).to eq('haha')
      expect(opt.question_id).to eq(ques.id)
      expect(opt.question_id.nil?).to eq(false)
      expect(Question.first.question).to eq('haha')
    end
    it 'check association' do
      ques = Question.create!(question: 'haha', answer: 'hahaha', question_type: 'choose')
      opt = Option.create!(option: '?', choice: '??', question: ques)
      expect(ques.answer).to eq(opt.question.answer)
      expect(ques.options.first).to eq(opt)
      expect(Question.first.options.first).to eq(opt)
    end

  end
end