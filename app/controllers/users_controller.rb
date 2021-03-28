require "json"
require "http"
require "optparse"


class UsersController < ApplicationController
  # before_action :set_user, only: %i[ show edit update destroy ]
  @@API_KEY = "cOvuE6J1hqqbEn_ByZMHUqXod80KtPv55iLvQ6G9zoiFtbYvLNtpzUrHE9cFnP4-jTl-5ha99bTNYQ7LAtCWJ2FerNpFlRF9KVBgFmNyXQ9YxPBkNj_DLElVq1M-YHYx"
  @@API_HOST = "https://api.yelp.com"
  @@SEARCH_PATH = "/v3/businesses/search"
  @@BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path
  @@QUESTION_ID = Question.generate_question.id

  def search
    @user = load_user
    @from_other_page = !params[:commit].present?

    @TERM = ""
    if params[:term] != nil
      @TERM = params[:term]
    end

    @LOCATION = ""
    @search_error = nil
    if params[:location].present?
      @LOCATION = params[:location]
    else
      @search_error = "location can not be empty!"
    end

    @businesses = []
    if @search_error == nil
      @businesses = yelp_business_search(@TERM, @LOCATION, 15)
      render "search"
    else
      home()
    end
  end




  def recommend
    @user = load_user
    @response = Question.generate_response(@@QUESTION_ID, params[:choice]).to_s

    @LOCATION = ""
    @recommend_error = nil
    if params[:location].present?
      @LOCATION = params[:location]
    else
      @recommend_error = "location can not be empty!"
    end

    @businesses = []
    if @recommend_error == nil
      @businesses = get_recommend(@LOCATION)
    end
    render "recommend"
  end

  def event
    @LOCATION = ""
    if params[:location].present?
      @LOCATION = params[:location]
    else
      @LOCATION = "New York"
    end

    @events = []
    url = "#{@@API_HOST}#{@@EVENT_PATH}"
    params = {
      location: @LOCATION,
      limit: 10
    }
    response = HTTP.auth("Bearer #{@@API_KEY}").get(url, params: params)
    response_body_hash = JSON.parse(response.body)
    @events = response_body_hash["events"]
    puts "**************"
    puts @events[0]
    puts "**************"
    render "event"
  end



  def login
    @email = params[:email]
    @password = params[:password]
    @user = User.find_by(email: @email)
    @login_errors = []
    if @email == ""
      @login_errors.push("email is empty")
    elsif @user == nil
      @login_errors.push("user does not exist, please register first")
    end

    if @password == ""
      @login_errors.push("password is empty")
    elsif @user != nil and @password != @user.password_digest
      @login_errors.push("password is not correct")
    end
    if @login_errors.empty?
      store_user(@user.id)
      redirect_to action: "home"   
    else
      render "welcome"
    end
  end





  def signup
    @email = params[:email]
    @password = params[:password]
    @re_password = params[:re_password]
    @signup_errors = []
    if @email == ""
      @signup_errors.push("email is empty")
    end

    if @password == "" or @re_password == ""
      @signup_errors.push("Password or re-password is empty!")
    end

    if @password != @re_password
      @signup_errors.push("Password and Re-password do not match!")
    end

    if User.find_by(email: @email) != nil
      @signup_errors.push("This email has been registered!")
    end

    if @signup_errors.length() > 0
      render "welcome"
    else
      @new_user = User.create(email: @email, password_digest: @password)
      if @new_user.save()
        store_user(@new_user.id)
        redirect_to action: "question", id:@new_user.id
      else
        @signup_errors.push("Sorry, signing up failed somehow, please try again.")
        render "welcome"
      end
    end
  end




  def show   
    @user = load_user 
    render "show"
  end




  def edit
    @user = load_user
    if params[:commit] == "Change my profile"
      @user = load_user
      @user.first_name = params[:first_name]
      @user.last_name = params[:last_name]
      @user.nick_name = params[:nick_name]
      @user.gender = params[:gender]
      @user.age = params[:age]
      @user.food_preference = params[:food_preference]
      @user.save
      redirect_to "/user"
    else
      render "edit"
    end
  end





  def home
    @user = load_user()
    @question = load_question(@@QUESTION_ID)
    @options = []
    for o in @question.options do
      @options.append(o["option"])
    end
    @businesses = yelp_business_search("", "New York", 9)
    @user_reviews = Review.get_user_reviews(@user.id)
    render "home"
  end







  def question_update
    @user = User.find(params[:id])
    @user.food_preference = params[:food_preference]
    @user.save
    redirect_to "/home"
  end





  private
   
    
    def store_user(id)
      session[:user_id] = id
    end
    
    def load_user
      return User.find_by({id:session[:user_id]})
    end

    def load_question(question_id)
      return Question.find_by({id:@@QUESTION_ID})
    end

    def get_recommend(location)
      user = load_user
      preference = User.find_by_id(user.id).food_preference
      businesses = []
      businesses = yelp_business_search(preference, location, 10)
      return businesses
    end

    def yelp_business_search(term, location, limit)
      url = "#{@@API_HOST}#{@@SEARCH_PATH}"
      params = {
        term: term,
        location: location,
        limit: limit
      }
      response = HTTP.auth("Bearer #{@@API_KEY}").get(url, params: params)
      response_body_hash = JSON.parse(response.body)
      businesses = response_body_hash["businesses"]
      return businesses
    end
end
