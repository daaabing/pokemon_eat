# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
case Rails.env

when "development"
    users = User.create([
        {email: "zhengchuan000@gmail.com", password_digest: "1", food_preference: "chinese"},
        {email: "807442894@qq.com", password_digest: "1", food_preference: "french"},
        {email: "hzwang@ucdavis.edu", password_digest: "1", food_preference: "korean"},
        {email: "heyunong1223@gmail.com", password_digest: "1"},
    ])
    
    questions_list = [
        {question: "Are you a cat person or a dog person?", answer: 
        "A [] appears behind you and says he wants to visit these restaurants~", question_type: "choose"},
        {question: "What kind of music do you like?", answer: 
            "If you like [], you might like these restaurants!", question_type: "choose"},
        {question: "How is the weather today?", answer: 
        "It would be great to visit these restaurants in [] weather~", question_type: "choose"},
        {question: "What color are you in today?", answer: 
        "If you are in [], you'll be better matched with these restaurants", question_type: "choose"},
        {question: "What kind of hairstyle do you have today?", answer: 
            "I heard that people with [] will get good luck when they go to these restaurants today", question_type: "choose"},
        {question: "What is the first thing you do when you get up in the morning?", answer: 
            "If you [] firstly in the morning, I guess you'll like these restaurants!", question_type: "choose"},
        {question: "Do you like Pepsi or Coca-Cola?", answer: 
        "If you like [], you should also like these restaurants~", question_type: "choose"},
        {question: "Do you prefer to go to bed late or early?", answer: 
        "One day when you go to bed [], you seem to see these restaurants in meditation. Is this a sign of something?", question_type: "choose"},
        {question: "Which aroma do you like?", answer: 
            "After lighting the [] flavor candle, you see these restaurants in the light smoke that rises. What might you gain by visiting today?", question_type: "choose"},
        {question: "Do you like salty tofu pudding or sweet tofu pudding?", answer: 
            "If you're a fan of [] tofu pudding, you might like these restaurants~", question_type: "choose"},
        {question: "What is your constellation?", answer: 
            "According to the tarot cards, [] people will get good luck if they go to these restaurants today~", question_type: "choose"},
        {question: "What is your favorite season?", answer: 
            "These restaurants would be a good place to go in the []. Certainly in other seasons as well.", question_type: "choose"},
        
        # {question: "Who is your favorite fictional character?", answer: 
        #     "I heard that [] secretly visited these restaurants a few days ago.", question_type: "fill"},
        # {question: "Who is your dating type?", answer: 
        #     "[] would like to invite you to these restaurants!", question_type: "fill"},
        # {question: "Please enter your best friend's name", answer: 
        #     "[] sneaks up on you and says he wants to go to these restaurants.", question_type: "fill"},
    ]
    
    questions = Question.create!(questions_list)
    
    options = Option.create!([
        {option: "cat person!", choice: "kitten", question: Question.find(1)},
        {option: "dog person!", choice: "puppy", question: Question.find(1)},
        {option: "Rock", choice: "rock", question: Question.find(2)},
        {option: "Rap", choice: "rap", question: Question.find(2)},
        {option: "Pop", choice: "pop", question: Question.find(2)},
        {option: "Country", choice: "country", question: Question.find(2)},
        {option: "Classical", choice: "classical", question: Question.find(2)},
        {option: "Sunny", choice: "sunny", question: Question.find(3)},
        {option: "Rainy", choice: "rainy", question: Question.find(3)},
        {option: "Snowy", choice: "snowy", question: Question.find(3)},
        {option: "Cloudy", choice: "cloudy", question: Question.find(3)},
        {option: "Red", choice: "red", question: Question.find(4)},
        {option: "Blue", choice: "blue", question: Question.find(4)},
        {option: "Green", choice: "green", question: Question.find(4)},
        {option: "Purple", choice: "purple", question: Question.find(4)},
        {option: "Yellow", choice: "yellow", question: Question.find(4)},
        {option: "Shoulder-length hair", choice: "shoulder-length hair", question: Question.find(5)},
        {option: "Long curly hair", choice: "long curly hair", question: Question.find(5)},
        {option: "Long straight hair", choice: "long straight hair", question: Question.find(5)},
        {option: "Short hair", choice: "short hair", question: Question.find(5)},
        {option: "Brush my teeth.", choice: "brush teeth", question: Question.find(6)},
        {option: "No doubt, play with mobile phone", choice: "play with mobile phone", question: Question.find(6)},
        {option: "Take a cup of coffee!", choice: "drink coffee", question: Question.find(6)},
        {option: "Pepsi", choice: "pepsi", question: Question.find(7)},
        {option: "Coca-Cola", choice: "coca", question: Question.find(7)},
        {option: "It must be going to bed late, I'm going to stay through the night", choice: "late", question: Question.find(8)},
        {option: "Go to bed early and get up early.", choice: "early", question: Question.find(8)},
        {option: "Pine wood", choice: "pine wood", question: Question.find(9)},
        {option: "Lavender", choice: "lavender", question: Question.find(9)},
        {option: "Lily", choice: "lily", question: Question.find(9)},
        {option: "Orange", choice: "orange", question: Question.find(9)},
        {option: "Salty! Sweet tofu pudding is a heresy.", choice: "salty", question: Question.find(10)},
        {option: "Sweet! Salty tofu pudding tastes awful！", choice: "sweet", question: Question.find(10)},
        {option: "Aries", choice: "Aries", question: Question.find(11)},
        {option: "Taurus", choice: "Taurus", question: Question.find(11)},
        {option: "Gemini", choice: "Gemini", question: Question.find(11)},
        {option: "Cancer", choice: "Cancer", question: Question.find(11)},
        {option: "Leo", choice: "Leo", question: Question.find(11)},
        {option: "Virgo", choice: "Virgo", question: Question.find(11)},
        {option: "Libra", choice: "Libra", question: Question.find(11)},
        {option: "Scorpio", choice: "Scorpio", question: Question.find(11)},
        {option: "Sagittarius", choice: "Sagittarius", question: Question.find(11)},
        {option: "Capricorn", choice: "Capricorn", question: Question.find(11)},
        {option: "Aquarius", choice: "Aquarius", question: Question.find(11)},
        {option: "Pisces", choice: "Pisces", question: Question.find(11)},
        {option: "Spring", choice: "spring", question: Question.find(12)},
        {option: "Summer", choice: "summer", question: Question.find(12)},
        {option: "Autumn", choice: "autumn", question: Question.find(12)},
        {option: "Winter", choice: "winter", question: Question.find(12)},
    ])


when "test"
    users = User.create([
        {email: "zhengchuan000@gmail.com", password_digest: "1", food_preference: "chinese"},
        {email: "807442894@qq.com", password_digest: "1", food_preference: "french"},
        {email: "hzwang@ucdavis.edu", password_digest: "1", food_preference: "korean"},
        {email: "heyunong1223@gmail.com", password_digest: "1"},
    ])
    
    questions_list = [
        {question: "Are you a cat person or a dog person?", answer: 
        "A [] appears behind you and says he wants to visit these restaurants~", question_type: "choose"},
        {question: "What kind of music do you like?", answer: 
            "If you like [], you might like these restaurants!", question_type: "choose"},
        {question: "How is the weather today?", answer: 
        "It would be great to visit these restaurants in [] weather~", question_type: "choose"},
        {question: "What color are you in today?", answer: 
        "If you are in [], you'll be better matched with these restaurants", question_type: "choose"},
        {question: "What kind of hairstyle do you have today?", answer: 
            "I heard that people with [] will get good luck when they go to these restaurants today", question_type: "choose"},
        {question: "What is the first thing you do when you get up in the morning?", answer: 
            "If you [] firstly in the morning, I guess you'll like these restaurants!", question_type: "choose"},
        {question: "Do you like Pepsi or Coca-Cola?", answer: 
        "If you like [], you should also like these restaurants~", question_type: "choose"},
        {question: "Do you prefer to go to bed late or early?", answer: 
        "One day when you go to bed [], you seem to see these restaurants in meditation. Is this a sign of something?", question_type: "choose"},
        {question: "Which aroma do you like?", answer: 
            "After lighting the [] flavor candle, you see these restaurants in the light smoke that rises. What might you gain by visiting today?", question_type: "choose"},
        {question: "Do you like salty tofu pudding or sweet tofu pudding?", answer: 
            "If you're a fan of [] tofu pudding, you might like these restaurants~", question_type: "choose"},
        {question: "What is your constellation?", answer: 
            "According to the tarot cards, [] people will get good luck if they go to these restaurants today~", question_type: "choose"},
        {question: "What is your favorite season?", answer: 
            "These restaurants would be a good place to go in the []. Certainly in other seasons as well.", question_type: "choose"},
        
        # {question: "Who is your favorite fictional character?", answer: 
        #     "I heard that [] secretly visited these restaurants a few days ago.", question_type: "fill"},
        # {question: "Who is your dating type?", answer: 
        #     "[] would like to invite you to these restaurants!", question_type: "fill"},
        # {question: "Please enter your best friend's name", answer: 
        #     "[] sneaks up on you and says he wants to go to these restaurants.", question_type: "fill"},
    ]
    
    questions = Question.create!(questions_list)
    
    options = Option.create!([
        {option: "cat person!", choice: "kitten", question: Question.find(1)},
        {option: "dog person!", choice: "puppy", question: Question.find(1)},
        {option: "Rock", choice: "rock", question: Question.find(2)},
        {option: "Rap", choice: "rap", question: Question.find(2)},
        {option: "Pop", choice: "pop", question: Question.find(2)},
        {option: "Country", choice: "country", question: Question.find(2)},
        {option: "Classical", choice: "classical", question: Question.find(2)},
        {option: "Sunny", choice: "sunny", question: Question.find(3)},
        {option: "Rainy", choice: "rainy", question: Question.find(3)},
        {option: "Snowy", choice: "snowy", question: Question.find(3)},
        {option: "Cloudy", choice: "cloudy", question: Question.find(3)},
        {option: "Red", choice: "red", question: Question.find(4)},
        {option: "Blue", choice: "blue", question: Question.find(4)},
        {option: "Green", choice: "green", question: Question.find(4)},
        {option: "Purple", choice: "purple", question: Question.find(4)},
        {option: "Yellow", choice: "yellow", question: Question.find(4)},
        {option: "Shoulder-length hair", choice: "shoulder-length hair", question: Question.find(5)},
        {option: "Long curly hair", choice: "long curly hair", question: Question.find(5)},
        {option: "Long straight hair", choice: "long straight hair", question: Question.find(5)},
        {option: "Short hair", choice: "short hair", question: Question.find(5)},
        {option: "Brush my teeth.", choice: "brush teeth", question: Question.find(6)},
        {option: "No doubt, play with mobile phone", choice: "play with mobile phone", question: Question.find(6)},
        {option: "Take a cup of coffee!", choice: "drink coffee", question: Question.find(6)},
        {option: "Pepsi", choice: "pepsi", question: Question.find(7)},
        {option: "Coca-Cola", choice: "coca", question: Question.find(7)},
        {option: "It must be going to bed late, I'm going to stay through the night", choice: "late", question: Question.find(8)},
        {option: "Go to bed early and get up early.", choice: "early", question: Question.find(8)},
        {option: "Pine wood", choice: "pine wood", question: Question.find(9)},
        {option: "Lavender", choice: "lavender", question: Question.find(9)},
        {option: "Lily", choice: "lily", question: Question.find(9)},
        {option: "Orange", choice: "orange", question: Question.find(9)},
        {option: "Salty! Sweet tofu pudding is a heresy.", choice: "salty", question: Question.find(10)},
        {option: "Sweet! Salty tofu pudding tastes awful！", choice: "sweet", question: Question.find(10)},
        {option: "Aries", choice: "Aries", question: Question.find(11)},
        {option: "Taurus", choice: "Taurus", question: Question.find(11)},
        {option: "Gemini", choice: "Gemini", question: Question.find(11)},
        {option: "Cancer", choice: "Cancer", question: Question.find(11)},
        {option: "Leo", choice: "Leo", question: Question.find(11)},
        {option: "Virgo", choice: "Virgo", question: Question.find(11)},
        {option: "Libra", choice: "Libra", question: Question.find(11)},
        {option: "Scorpio", choice: "Scorpio", question: Question.find(11)},
        {option: "Sagittarius", choice: "Sagittarius", question: Question.find(11)},
        {option: "Capricorn", choice: "Capricorn", question: Question.find(11)},
        {option: "Aquarius", choice: "Aquarius", question: Question.find(11)},
        {option: "Pisces", choice: "Pisces", question: Question.find(11)},
        {option: "Spring", choice: "spring", question: Question.find(12)},
        {option: "Summer", choice: "summer", question: Question.find(12)},
        {option: "Autumn", choice: "autumn", question: Question.find(12)},
        {option: "Winter", choice: "winter", question: Question.find(12)},
    ])
when "production"
    users = User.create([
        {email: "zhengchuan000@gmail.com", password_digest: "1", food_preference: "chinese"},
        {email: "807442894@qq.com", password_digest: "1", food_preference: "french"},
        {email: "hzwang@ucdavis.edu", password_digest: "1", food_preference: "korean"},
        {email: "heyunong1223@gmail.com", password_digest: "1"},
    ])
    
    questions_list = [
        {question: "Are you a cat person or a dog person?", answer: 
        "A [] appears behind you and says he wants to visit these restaurants~", question_type: "choose"},
        {question: "What kind of music do you like?", answer: 
            "If you like [], you might like these restaurants!", question_type: "choose"},
        {question: "How is the weather today?", answer: 
        "It would be great to visit these restaurants in [] weather~", question_type: "choose"},
        {question: "What color are you in today?", answer: 
        "If you are in [], you'll be better matched with these restaurants", question_type: "choose"},
        {question: "What kind of hairstyle do you have today?", answer: 
            "I heard that people with [] will get good luck when they go to these restaurants today", question_type: "choose"},
        {question: "What is the first thing you do when you get up in the morning?", answer: 
            "If you [] firstly in the morning, I guess you'll like these restaurants!", question_type: "choose"},
        {question: "Do you like Pepsi or Coca-Cola?", answer: 
        "If you like [], you should also like these restaurants~", question_type: "choose"},
        {question: "Do you prefer to go to bed late or early?", answer: 
        "One day when you go to bed [], you seem to see these restaurants in meditation. Is this a sign of something?", question_type: "choose"},
        {question: "Which aroma do you like?", answer: 
            "After lighting the [] flavor candle, you see these restaurants in the light smoke that rises. What might you gain by visiting today?", question_type: "choose"},
        {question: "Do you like salty tofu pudding or sweet tofu pudding?", answer: 
            "If you're a fan of [] tofu pudding, you might like these restaurants~", question_type: "choose"},
        {question: "What is your constellation?", answer: 
            "According to the tarot cards, [] people will get good luck if they go to these restaurants today~", question_type: "choose"},
        {question: "What is your favorite season?", answer: 
            "These restaurants would be a good place to go in the []. Certainly in other seasons as well.", question_type: "choose"},
        
        # {question: "Who is your favorite fictional character?", answer: 
        #     "I heard that [] secretly visited these restaurants a few days ago.", question_type: "fill"},
        # {question: "Who is your dating type?", answer: 
        #     "[] would like to invite you to these restaurants!", question_type: "fill"},
        # {question: "Please enter your best friend's name", answer: 
        #     "[] sneaks up on you and says he wants to go to these restaurants.", question_type: "fill"},
    ]
    
    questions = Question.create!(questions_list)
    
    options = Option.create!([
        {option: "cat person!", choice: "kitten", question: Question.find(1)},
        {option: "dog person!", choice: "puppy", question: Question.find(1)},
        {option: "Rock", choice: "rock", question: Question.find(2)},
        {option: "Rap", choice: "rap", question: Question.find(2)},
        {option: "Pop", choice: "pop", question: Question.find(2)},
        {option: "Country", choice: "country", question: Question.find(2)},
        {option: "Classical", choice: "classical", question: Question.find(2)},
        {option: "Sunny", choice: "sunny", question: Question.find(3)},
        {option: "Rainy", choice: "rainy", question: Question.find(3)},
        {option: "Snowy", choice: "snowy", question: Question.find(3)},
        {option: "Cloudy", choice: "cloudy", question: Question.find(3)},
        {option: "Red", choice: "red", question: Question.find(4)},
        {option: "Blue", choice: "blue", question: Question.find(4)},
        {option: "Green", choice: "green", question: Question.find(4)},
        {option: "Purple", choice: "purple", question: Question.find(4)},
        {option: "Yellow", choice: "yellow", question: Question.find(4)},
        {option: "Shoulder-length hair", choice: "shoulder-length hair", question: Question.find(5)},
        {option: "Long curly hair", choice: "long curly hair", question: Question.find(5)},
        {option: "Long straight hair", choice: "long straight hair", question: Question.find(5)},
        {option: "Short hair", choice: "short hair", question: Question.find(5)},
        {option: "Brush my teeth.", choice: "brush teeth", question: Question.find(6)},
        {option: "No doubt, play with mobile phone", choice: "play with mobile phone", question: Question.find(6)},
        {option: "Take a cup of coffee!", choice: "drink coffee", question: Question.find(6)},
        {option: "Pepsi", choice: "pepsi", question: Question.find(7)},
        {option: "Coca-Cola", choice: "coca", question: Question.find(7)},
        {option: "It must be going to bed late, I'm going to stay through the night", choice: "late", question: Question.find(8)},
        {option: "Go to bed early and get up early.", choice: "early", question: Question.find(8)},
        {option: "Pine wood", choice: "pine wood", question: Question.find(9)},
        {option: "Lavender", choice: "lavender", question: Question.find(9)},
        {option: "Lily", choice: "lily", question: Question.find(9)},
        {option: "Orange", choice: "orange", question: Question.find(9)},
        {option: "Salty! Sweet tofu pudding is a heresy.", choice: "salty", question: Question.find(10)},
        {option: "Sweet! Salty tofu pudding tastes awful！", choice: "sweet", question: Question.find(10)},
        {option: "Aries", choice: "Aries", question: Question.find(11)},
        {option: "Taurus", choice: "Taurus", question: Question.find(11)},
        {option: "Gemini", choice: "Gemini", question: Question.find(11)},
        {option: "Cancer", choice: "Cancer", question: Question.find(11)},
        {option: "Leo", choice: "Leo", question: Question.find(11)},
        {option: "Virgo", choice: "Virgo", question: Question.find(11)},
        {option: "Libra", choice: "Libra", question: Question.find(11)},
        {option: "Scorpio", choice: "Scorpio", question: Question.find(11)},
        {option: "Sagittarius", choice: "Sagittarius", question: Question.find(11)},
        {option: "Capricorn", choice: "Capricorn", question: Question.find(11)},
        {option: "Aquarius", choice: "Aquarius", question: Question.find(11)},
        {option: "Pisces", choice: "Pisces", question: Question.find(11)},
        {option: "Spring", choice: "spring", question: Question.find(12)},
        {option: "Summer", choice: "summer", question: Question.find(12)},
        {option: "Autumn", choice: "autumn", question: Question.find(12)},
        {option: "Winter", choice: "winter", question: Question.find(12)},
    ])


end


#---used for debug---
# puts Option.first.option
# puts Question.first.question
# puts Option.first.question.question
# puts Question.first.options.first.option
# puts Question.group(:question).count
# puts Question.count