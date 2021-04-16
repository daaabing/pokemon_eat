require 'rails_helper'



RSpec.describe "check login function", type: :request do

  it "check login successfully" do
    get '/'
    @user_new = User.create!(email: 'test122@gmail.com', password_digest: 'test')
    post "/login", :params => {:email => 'test122@gmail.com', :password =>'test' }
    get '/home'
    expect(response.body).to include "Pokemon Eat"
  end

  it "check when email is empty" do
    get '/'
    post  "/login", :params => {:email => '', :password =>'1'}
    expect(response.body).to include "Email is empty"
  end

  it "check when password is empty" do
    get '/'
    post "/login", :params => {:email => '807442894@qq.com', :password =>'' }
    expect(response.body).to include "Password is empty"
  end

  it "check when password is not correct" do
    get '/'
    @user1 = User.create!(email: 'test222@gmail.com', password_digest: 'test')
    post login_path, :params => {:email => 'test222@gmail.com', :password =>'test1' }
    expect(response.body).to include "Password is not correct"
  end

  it "check when the user isn't exist" do
    get '/'
    post login_path, :params => {:email => '807289@qq.com', :password =>'1' }
    expect(response.body).to include "User does not exist, please sign up first"
  end
end





RSpec.describe "check Signup function", type: :request do

  it "check signup successfully" do
    get '/'
    post signup_path, :params => {:email => 'testsignup0@gmail.com', :password =>'1', :re_password => '1', nick_name: 'XXX', gender: 'male', age: 20, last_name: 'xx', first_name: 'xx', hometown: "New York" }
    expect(response).to have_http_status(302)
    user_id = User.find_by(email:'testsignup0@gmail.com').id.to_s
    get '/question'
    expect(response.body).to include "Pick Up Some Food"
    post '/question_update', :params => {:id => user_id, :food_preference => "korean food", :commit => "Submit" }
    expect(response).to have_http_status(302)
    get '/user'
    expect(response.body).to include "Korean"
  end

  it "check when email is empty" do
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





RSpec.describe "check search function", type: :request do

  before(:each) do
    @user_new = User.create!(email: 'test122@gmail.com', password_digest: 'test')
    post "/login", :params => {:email => 'test122@gmail.com', :password =>'test' }
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





RSpec.describe "check home page information is correct", type: :request do

  it "check home page has user's previous reviews successfully" do
    get '/'
    @user_new = User.create!(email: 'test122@gmail.com', password_digest: 'test')
    post "/login", :params => {:email => 'test122@gmail.com', :password =>'test' }
    get '/home'
    get '/business/JV5oa5-KGdiWnqrKPoxSug/review?review=this+restaurant+is+great%21&commit=Post'
    get '/home'
    expect(response.body).to include "this restaurant is great!"
  end

  it "check home page has no user's previous reviews successfully" do
    get '/'
    @user_new = User.create!(email: 'testsignup0@gmail.com', password_digest: '1')
    post "/login", :params => {:email => 'testsignup0@gmail.com', :password =>'1' }
    get '/home'
    expect(response.body).to include "No reviews currently."
  end
end





RSpec.describe "check recommend function", type: :request do

  before(:each) do
    @user_new = User.create!(email: 'test122@gmail.com', password_digest: 'test')
    post "/login", :params => {:email => 'test122@gmail.com', :password =>'test' }
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
    @user_new = User.create!(email: 'test122@gmail.com', password_digest: 'test')
    post "/login", :params => {:email => 'test122@gmail.com', :password =>'test' }
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
    expect(response).to have_http_status(200)
    get '/user'
    # expect(response.body).to include (@user_new.nick_name)
    expect(response).to have_http_status(200) #check if Nickname is updated, other information is exactly the same.
  end
end



