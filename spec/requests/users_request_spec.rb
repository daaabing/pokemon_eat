require 'rails_helper'


RSpec.describe "User Login", type: :request do

  it "check login successfully" do
    get '/'
    @user_new = User.create!(email: 'test122@gmail.com', password_digest: 'test')
    post "/login", :params => {:login_email => 'test122@gmail.com', :login_password =>'test' }
    get '/home'
    expect(response.body).to include "Pokemon Eat"
  end

  it "check when email is empty" do
    get '/'
    post  "/login", :params => {:login_email => '', :login_password =>'1'}
    expect(response.body).to include "Email is empty"
  end

  it "check when password is empty" do
    get '/'
    post "/login", :params => {:login_email => '807442894@qq.com', :login_password =>'' }
    expect(response.body).to include "Password is empty"
  end

  it "check when password is not correct" do
    get '/'
    @user1 = User.create!(email: 'test222@gmail.com', password_digest: 'test')
    post login_path, :params => {:login_email => 'test222@gmail.com', :login_password =>'test1' }
    expect(response.body).to include "Password is not correct"
  end

  it "check when the user isn't exist" do
    get '/'
    post login_path, :params => {:login_email => '807289@qq.com', :login_password =>'1' }
    expect(response.body).to include "User does not exist, please sign up first"
  end
end





RSpec.describe "User Sign Up", type: :request do

  it "check signup successfully" do
    get '/'
    post signup_path, :params => {:email => 'testsignup0@gmail.com', :password =>'1', :re_password => '1', nick_name: 'XXX', gender: 'male', age: 20, last_name: 'xx', first_name: 'xx', hometown: "New York" }
    expect(response).to have_http_status(302)
    user_id = User.find_by(email:'testsignup0@gmail.com').id.to_s
    $redis.hdel(user_id, "Korean")
    get '/question'
    expect(response.body).to include "Pick Up Some Food"
    post '/question_update', :params => {:id => user_id, "Korean" => "1", :commit => "Submit" }
    expect(response).to have_http_status(302)
    get '/user'
    expect(response.body).to include "New York"
  end

  it "check when Email is empty" do
    get '/'
    post signup_path, :params => {:email => '', :password =>'1', :re_password => '1' }
    expect(response.body).to include "Email is empty"
  end

  it "check when Nick Name is empty" do
    get '/'
    post signup_path, :params => {:email => 'testsignup0@gmail.com', :password =>'1', :re_password => '1', nick_name:''}
    expect(response.body).to include "Nick Name can not be Empty!"
    expect(response.body).to include "Please pick up a cute Nick Name :-p"
  end

  it "check when Location is empty" do
    get '/'
    post signup_path, :params => {:email => 'testsignup0@gmail.com', :password =>'1', :re_password => '1', hometown:'' }
    expect(response.body).to include "Location can not be Empty!"
  end

  it "check when Password and Re-password do not match!" do
    get '/'
    post signup_path, :params => {:email => 'testsignup1@gmail.com', :password =>'1', :re_password => '2' }
    expect(response.body).to include "Password and Re-password do not match"
  end

  it "check when the email has been registered" do
    get '/'
    @user1 = User.create!(email: 'test@gmail.com', password_digest: 'test')
    post signup_path, :params => {:email => 'test@gmail.com', :password =>'test', :re_password => '1' }
    expect(response.body).to include "This email has been registered"
  end

  it "check when password or re-password is empty" do
    get '/'
    post signup_path, :params => {:email => 'testsignup2@gmail.com', :password =>'', :re_password => '1' }
    expect(response.body).to include "Password or re-password is empty"
    post signup_path, :params => {:email => 'testsignup2@gmail.com', :password =>'1', :re_password => '' }
    expect(response.body).to include "Password or re-password is empty"
  end
end





RSpec.describe "Search", type: :request do

  before(:each) do
    @user_new = User.create!(email: 'test122@gmail.com', password_digest: 'test')
    post "/login", :params => {:login_email => 'test122@gmail.com', :login_password =>'test' }
    get '/home'
  end

  it "search with term and location" do
    get '/search/?term=seafood&location=New+York&commit=Search'
    expect(response.body).to include "seafood"
    expect(response.body).to include "Near"
    expect(response.body).to include "New York"
  end

  it "search with only term" do
    get '/search/?term=seafood&location=&commit=Search'
    expect(response).to have_http_status(200)
    expect(response.body).to include "location can not be empty!"
  end

  it "search with only loaction" do
    get '/search/?term=&location=New+York&commit=Search'
    expect(response.body).to include "Near"
    expect(response.body).to include "New York"
  end

  it "search with blank inputs" do
    get '/search/?term=&location=&commit=Search'
    expect(response).to have_http_status(200)
    expect(response.body).to include "location can not be empty!"
  end
end





RSpec.describe "Home page shows user's reviews", type: :request do

  it "check home page has user's previous reviews successfully" do
    get '/'
    @user_new = User.create!(email: 'test122@gmail.com', password_digest: 'test')
    post "/login", :params => {:login_email => 'test122@gmail.com', :login_password =>'test' }
    get '/home'
    get '/business/JV5oa5-KGdiWnqrKPoxSug/review?review=this+restaurant+is+great%21&commit=Post'
    get '/home'
    expect(response.body).to include "this restaurant is great!"
  end

  it "check home page has no user's previous reviews successfully" do
    get '/'
    @user_new = User.create!(email: 'testsignup0@gmail.com', password_digest: '1')
    post "/login", :params => {:login_email => 'testsignup0@gmail.com', :login_password =>'1' }
    get '/home'
    expect(response.body).to include "No reviews currently."
  end
end





RSpec.describe "Recommend", type: :request do

  before(:each) do
    @user_new = User.create!(email: 'test122@gmail.com', password_digest: 'test')
    post "/login", :params => {:login_email => 'test122@gmail.com', :login_password =>'test' }
    get '/home'
  end

  it "recommend without location" do
    get '/recommend/?choice=Brush+my+teeth.&location=&commit=Recommend%21'
    expect(response.body).to include "location can not be empty!"
  end

  it "recommend with choice question and location" do
    get '/recommend/?choice=Brush+my+teeth.&location=169+Manhattan+Ave%2C+New+York%2C+NY+10025-3229%2C+United+States&commit=Recommend%21'
    expect(response.body).to include "Your Current Food Preference"
  end
end






RSpec.describe "check user profile function", type: :request do
  before(:each) do
    @user_new = User.create!(email: 'test122@gmail.com', password_digest: 'test', nick_name:'Rui')
    post "/login", :params => {:login_email => 'test122@gmail.com', :login_password =>'test' }
    get '/home'
  end

  it "check user profile page shows user information" do
    get '/user'
    expect(response.body).to include "Edit"
    expect(response.body).to include "Log Out"
  end

  it "check edit user profile and it shows on user profile" do
    get '/edit_profile'
    get '/edit_profile?first_name=Chuan&last_name=Zhou&nick_name=Trible&gender=Male&age=24&food_preference=korean+food&location=New+York&commit=Change+my+profile'
    @user_new.first_name = 'Chuan'
    @user_new.last_name = 'Zhou'
    @user_new.nick_name = 'Rui1'
    expect(response).to have_http_status(200)
    get '/user'
    expect(response).to have_http_status(200) #check if Nickname is updated, other information is exactly the same.
    expect(response.body).to include "Rui"
  end
end





RSpec.describe "User Profile", type: :feature do
  before :each do
    @user_new = User.create!(email: 'test12223@gmail.com', password_digest: 'test', nick_name:'Rui')
    @user_new1 = User.create!(email: 'test122222@gmail.com', password_digest: 'test', nick_name:'Rui')
    @review = Review.create!(user_id:@user_new.id, business_id:"H4jJ7XB3CetIr1pg56CczQ", review:'Good!', created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    @like = Like.create!(user_id:@user_new.id, business_id:"H4jJ7XB3CetIr1pg56CczQ", created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    Review.create!(user_id:@user_new1.id, business_id:"H4jJ7XB3CetIr1pg56CczQ", review:'Good!', created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    Like.create!(user_id:@user_new1.id, business_id:"H4jJ7XB3CetIr1pg56CczQ", created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    BookedEvent.create!(user_id:@user_new1.id, event_id:"new-york-yelps-10th-burstday", created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    Friend.create!(user_id:@user_new.id, friend_id:@user_new1.id, created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    Friend.create!(user_id:@user_new1.id, friend_id:@user_new.id, created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    @event = BookedEvent.create!(user_id:@user_new.id, event_id:"new-york-yelps-10th-burstday", created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    visit '/welcome'
    fill_in 'login_email', with: 'test12223@gmail.com'
    fill_in 'login_password', with: 'test'
    click_button 'Login'
  end

  it "check user profile page changes user information" do
    visit '/user'
    click_button 'Edit'
    fill_in 'nick_name', with: 'name1'
    fill_in 'age', with: '20'
    fill_in 'hometown', with: 'New York'
    click_button 'Save'
    expect(page).to have_content 'name1'
  end

  it "check reviews nav-bar links" do
    visit '/user'
    click_on('My Reviews')
    expect(page).to have_content 'Good!'
  end

  it "check Starred Restaurants nav-bar links" do
    visit '/user'
    click_on('Starred Restaurants')
    expect(page).to have_content 'Levain Bakery'
    expect(page).to have_content 'Visit the restaurant'
    click_on('Visit the restaurant')
    expect(page).to have_content 'Thumbs Up'
  end

  it "check events nav-bar links" do
    visit '/user'
    click_on('Booked Events')
    expect(page).to have_content '10th Burstday!'
    click_on('Following')
    expect(page).to have_content 'Visit the event'
    click_on('Visit the event')
    expect(page).to have_content 'Quick Info'
  end

  it "check following nav-bar links" do
    visit '/user'
    click_on('Following')
    expect(page).to have_content 'Visit this user'
    click_on('Visit this user')
    expect(page).to have_content 'Follow this user'
    click_button 'Follow this user'
    expect(page).to have_content 'Follow this user'
  end

  it "check reviews nav-bar links" do
    visit '/user'
    click_on('Log Out')
    expect(page).to have_content 'Boost up your daily food choices'
  end
end

RSpec.describe "Other user page", type: :feature do
  before :each do
    @user_new = User.create!(email: 'test12223@gmail.com', password_digest: 'test', nick_name:'Rui')
    @user_new1 = User.create!(email: 'test122222@gmail.com', password_digest: 'test', nick_name:'Rui')
    @review = Review.create!(user_id:@user_new.id, business_id:"H4jJ7XB3CetIr1pg56CczQ", review:'Good!', created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    @like = Like.create!(user_id:@user_new.id, business_id:"H4jJ7XB3CetIr1pg56CczQ", created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    Review.create!(user_id:@user_new1.id, business_id:"H4jJ7XB3CetIr1pg56CczQ", review:'Good!', created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    Like.create!(user_id:@user_new1.id, business_id:"H4jJ7XB3CetIr1pg56CczQ", created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    BookedEvent.create!(user_id:@user_new1.id, event_id:"new-york-yelps-10th-burstday", created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    Friend.create!(user_id:@user_new.id, friend_id:@user_new1.id, created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    Friend.create!(user_id:@user_new1.id, friend_id:@user_new.id, created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    @event = BookedEvent.create!(user_id:@user_new.id, event_id:"new-york-yelps-10th-burstday", created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    visit '/welcome'
    fill_in 'login_email', with: 'test12223@gmail.com'
    fill_in 'login_password', with: 'test'
    click_button 'Login'
    visit '/user'
    click_on('Following')
    expect(page).to have_content 'Visit this user'
    click_on('Visit this user')
  end

  it "check reviews nav-bar links" do
    click_on('My Reviews')
    expect(page).to have_content 'Good!'
  end

  it "check Starred Restaurants nav-bar links" do
    click_on('Starred Restaurants')
    expect(page).to have_content 'Levain Bakery'
    expect(page).to have_content 'Visit the restaurant'
    click_on('Visit the restaurant')
    expect(page).to have_content 'Thumbs Up'
  end

  it "check events nav-bar links" do
    click_on('Booked Events')
    expect(page).to have_content '10th Burstday!'
    click_on('Following')
    expect(page).to have_content 'Visit the event'
    click_on('Visit the event')
    expect(page).to have_content 'Quick Info'
  end

  it "check following nav-bar links" do
    click_on('Following')
    expect(page).to have_content 'Back to My Page'
    click_on('Back to My Page')
    expect(page).to have_content 'Edit'
  end

end

RSpec.describe "follow users", type: :feature do
  before :each do
    @user_new = User.create!(email: 'test12223@gmail.com', password_digest: 'test', nick_name:'Rui', hometown: "New York")
    @user_new1 = User.create!(email: 'test122222@gmail.com', password_digest: 'test', nick_name:'Rui1', hometown: "New York")
    @user_new2 = User.create!(email: 'test123333@gmail.com', password_digest: 'test', nick_name:'XXX', hometown: "New York")
    Review.create!(user_id:@user_new.id, business_id:"H4jJ7XB3CetIr1pg56CczQ", review:'Good!', created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    Review.create!(user_id:@user_new1.id, business_id:"H4jJ7XB3CetIr1pg56CczQ", review:'Good!', created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    Review.create!(user_id:@user_new2.id, business_id:"H4jJ7XB3CetIr1pg56CczQ", review:'Good!', created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    visit '/welcome'
    fill_in 'login_email', with: 'test12223@gmail.com'
    fill_in 'login_password', with: 'test'
    click_button 'Login'
  end

  it "check preference" do
    # click_on('Levain Bakery')
    visit '/business/H4jJ7XB3CetIr1pg56CczQ'
    expect(page).to have_content 'Thumbs Up'
    click_button 'Thumbs Up'
    expect(page).to have_content 'Levain Bakery'
  end

  it "check review" do
    # click_on('Levain Bakery')
    visit '/business/H4jJ7XB3CetIr1pg56CczQ'
    expect(page).to have_content 'Thumbs Up'
    click_button 'Write a Review'
    expect(page).to have_content 'Write up Your Reivew'
    fill_in 'review', with: 'Good!'
    click_button 'Post'
    expect(page).to have_content 'Good!'
  end

  it "follow users" do
    # click_on('Levain Bakery')
    visit '/business/H4jJ7XB3CetIr1pg56CczQ'
    expect(page).to have_content 'XXX'
    click_on('XXX')
    expect(page).to have_content 'Follow this user'
    Friend.create!(user_id:@user_new.id, friend_id:@user_new2.id, created_at:'2021-04-03 11:11:11', updated_at:'2021-04-03 11:11:11')
    click_button 'Follow this user'
    expect(page).to have_content 'XXX'
  end

  it "check nil" do
    visit '/user'
    click_on('My Reviews')
  end

end

RSpec.describe "register events and thumb up restaurants", type: :request do
  before(:each) do
    @user_new = User.create!(email: 'test122@gmail.com', password_digest: 'test', hometown: "New York")
    post "/login", :params => {:login_email => 'test122@gmail.com', :login_password =>'test' }
    get '/home'
  end

  it "check thumb up a restaurant, this will add a new category to user's food preference" do
    $redis.del("1gXKzs-1EPxJ7gkHW6SDyg")
    $redis.hdel(@user_new.id.to_s, "Bubble Tea")
    get '/business/1gXKzs-1EPxJ7gkHW6SDyg'
    expect(response).to have_http_status(200)
    get '/like/1gXKzs-1EPxJ7gkHW6SDyg'
    expect(response).to have_http_status(302)
  end

  it "check thumb up a restaurant, pre-cached in Redis" do
    get '/business/H4jJ7XB3CetIr1pg56CczQ'
    expect(response).to have_http_status(200)
    get '/like/H4jJ7XB3CetIr1pg56CczQ'
    business_json = $redis.get("H4jJ7XB3CetIr1pg56CczQ")
    business = JSON.parse(business_json)
    expect(response).to have_http_status(302)
  end

  it "check thumb up a restaurant, requesting from Yelp" do
    get '/business/H4jJ7XB3CetIr1pg56CczQ'
    expect(response).to have_http_status(200)
    $redis.del("H4jJ7XB3CetIr1pg56CczQ")
    get '/like/H4jJ7XB3CetIr1pg56CczQ'
    expect(response).to have_http_status(302)
  end

  it "check book an event, pre-cached in Redis" do
    get '/event/new-york-yelps-10th-burstday'
    expect(response).to have_http_status(200)
    get '/book/new-york-yelps-10th-burstday'
    expect(response).to have_http_status(302)
  end

  it "check book an event, requesting from Yelp" do
    $redis.del("new-york-yelps-10th-burstday")
    get '/event/new-york-yelps-10th-burstday'
    expect(response).to have_http_status(200)
    get '/book/new-york-yelps-10th-burstday'
    event_json = $redis.get("new-york-yelps-10th-burstday")
    event = JSON.parse(event_json)
    expect(response).to have_http_status(302)
  end

end

RSpec.describe "select preference&update questions", type: :feature do
  before :each do
    @user_new = User.create!(email: 'test12223@gmail.com', password_digest: 'test', nick_name:'Rui', hometown: "New York")
    visit '/welcome'
    fill_in 'login_email', with: 'test12223@gmail.com'
    fill_in 'login_password', with: 'test'
    click_button 'Login'
    visit '/question'
  end

  it "select preference" do
    check('Chinese')
    click_button 'Submit'
  end
end

RSpec.describe "Search and register Events", type: :feature do
  before :each do
    @user_new = User.create!(email: 'test12223@gmail.com', password_digest: 'test', nick_name:'Rui', hometown: "New York")
    visit '/welcome'
    fill_in 'login_email', with: 'test12223@gmail.com'
    fill_in 'login_password', with: 'test'
    click_button 'Login'
    visit '/home'
  end

  it "Search Events" do
    click_on ('Go for the event')
    expect(page).to have_content 'Near'
  end

  it "register Events" do
    visit '/event/new-york-yelps-10th-burstday'
    expect(page).to have_content'Quick Info'
    click_button 'Register Now'
    expect(page).to have_content'Quick Info'
  end
end

RSpec.describe "follow users", type: :request do
  before(:each) do
    @user_new = User.create!(email: 'test122@gmail.com', password_digest: 'test', nick_name:'Rui')
    @user_new1 = User.create!(email: 'test122345@gmail.com', password_digest: 'test', nick_name:'Rui')
    post "/login", :params => {:login_email => 'test122@gmail.com', :login_password =>'test' }
    get '/user'
  end

  it "check follow users" do
    get '/follow_user/' + @user_new1.id.to_s
    get '/other_user/' + @user_new1.id.to_s
    expect(response.body).to include "Rui"
  end
end




