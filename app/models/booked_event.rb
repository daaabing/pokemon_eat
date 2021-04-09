class BookedEvent < ApplicationRecord

  def self.book_this_event(event_id, user_id)
    entry = BookedEvent.create({user_id:user_id, event_id:event_id})
    entry.save()
  end

  def self.get_user_events(user_id)
    events = []
    if user_id != nil and BookedEvent.where(user_id:user_id) != nil
      events = BookedEvent.where(user_id:user_id).to_a
      events_id = []
      events.each do |e|
        if events_id.include?(e.event_id) == false
          events_id.append(e.event_id)
        end
      end
    end
    return events_id
  end


  
end
