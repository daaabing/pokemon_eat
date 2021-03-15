require 'rails_helper'

# --format documentation
RSpec.describe "check login function", type: :request do
  it "check login successfully" do
    get '/'
    @user_new = User.create!(email: 'test122@gmail.com', password_digest: 'test')
    post login_path, :params => {:email => 'test122@gmail.com', :password =>'test' }
    get '/users/' + @user_new.id.to_s
    expect(response.body).to include "Confirmed"
  end

  it "check when email is empty" do
    get '/'
    post login_path, :params => {:email => '', :password =>'1' }
    expect(response.body).to include "email is empty"
  end

  it "check when password is empty" do
    get '/'
    post login_path, :params => {:email => '807442894@qq.com', :password =>'' }
    expect(response.body).to include "password is empty"
  end

  it "check when password is not correct" do
    get '/'
    @user1 = User.create!(email: 'test222@gmail.com', password_digest: 'test')
    post login_path, :params => {:email => 'test222@gmail.com', :password =>'test1' }
    expect(response.body).to include "password is not correct"
  end

  it "check when the user isn't exist" do
    get '/'
    post login_path, :params => {:email => '807289@qq.com', :password =>'1' }
    expect(response.body).to include "user does not exist, please register first"
  end
end

RSpec.describe "check Signup function", type: :request do
  it "check signup successfully" do
    get '/'
    @user_new = User.create(email: 'testsignup0@gmail.com', password_digest: '1')
    post signup_path, :params => {:email => 'testsignup0@gmail.com', :password =>'1', :re_password => '1' }
    @user_new.save
    get '/users/' + @user_new.id.to_s
    expect(response.body).to include "Confirmed"
  end

  it "check when email is empty" do
    get '/'
    post signup_path, :params => {:email => '', :password =>'1', :re_password => '1' }
    expect(response.body).to include "email is empty"
  end

  it "check when Password and Re-password do not match!" do
    get '/'
    post signup_path, :params => {:email => 'testsignup1@gmail.com', :password =>'1', :re_password => '2' }
    expect(response.body).to include "Password and Re-password do not match!"
  end

  it "check when the email has been registered" do
    get '/'
    @user1 = User.create!(email: 'test@gmail.com', password_digest: 'test')
    post signup_path, :params => {:email => 'test@gmail.com', :password =>'test', :re_password => '1' }
    expect(response.body).to include "This email has been registered!"
  end

  it "check can't match the db" do
    get '/'
    post signup_path, :params => {:email => '807442894@qq.com' }
    expect(response.body).to include "Sorry, signing up failed somehow, please try again."
    puts response.body
  end

  it "check when password or re-password is empty" do
    get '/'
    post signup_path, :params => {:email => 'testsignup2@gmail.com', :password =>'', :re_password => '1' }
    expect(response.body).to include "Password or re-password is empty!"
    post signup_path, :params => {:email => 'testsignup2@gmail.com', :password =>'1', :re_password => '' }
    expect(response.body).to include "Password or re-password is empty!"
  end
end



RSpec.describe "check search function", type: :request do
  it "get on search page" do
    get '/search'
    expect(response).to have_http_status(200)
    expect(response.body).to include "please input your term and location"
  end

  it "search with term and location" do
    get '/search?term=seafood&location=New+York&commit=Search'
    expect(response.body).to include "Searching Results"
  end

  it "search with only term" do
    get '/search?term=seafood&location=&commit=Search'
    expect(response).to have_http_status(200)
    expect(response.body).to include "location can not be empty!"
  end

  it "seaech with only loaction" do
    get '/search?term=&location=New+York&commit=Search'
    expect(response.body).to include "Searching Results"
  end

  it "search with blank inputs" do
    get '/search?term=&location=&commit=Search'
    expect(response).to have_http_status(200)
    expect(response.body).to include "location can not be empty!"
  end
end
