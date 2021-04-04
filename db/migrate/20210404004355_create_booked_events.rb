class CreateBookedEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :booked_events do |t|
      t.string :user_id
      t.string :event_id

      t.timestamps
    end
  end
end
