class CreateOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :options do |t|
      t.text :option
      t.string :choice
      t.belongs_to :question, index: true

      t.timestamps
    end
  end
end
