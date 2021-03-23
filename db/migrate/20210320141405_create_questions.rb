class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :question
      t.text :answer
      t.string :question_type

      t.timestamps
    end
  end
end
