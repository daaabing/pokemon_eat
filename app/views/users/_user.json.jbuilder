json.extract! user, :id, :email, :confirmed, :food_preference, :created_at, :updated_at
json.url user_url(user, format: :json)
