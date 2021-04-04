class BookedEvent < ApplicationRecord

  def self.book_this_event(event_id, user_id)
    entry = BookedEvent.create({user_id:user_id, event_id:event_id})
    entry.save()
  end

  def self.get_user_events(user_id)
    events = []
    if user_id != nil and BookedEvent.where(user_id:user_id) != nil
      events = BookedEvent.where(user_id:user_id).to_a
    end
    return events
  end


  
end
