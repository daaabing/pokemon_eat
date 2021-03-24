class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :user_id
      t.string :business_id
      t.text :review
      t.timestamps
    end
  end
end
