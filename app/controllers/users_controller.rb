require "json"
require "http"
require "optparse"


class UsersController < ApplicationController
  # before_action :set_user, only: %i[ show edit update destroy ]
  @@API_KEY = "cOvuE6J1hqqbEn_ByZMHUqXod80KtPv55iLvQ6G9zoiFtbYvLNtpzUrHE9cFnP4-jTl-5ha99bTNYQ7LAtCWJ2FerNpFlRF9KVBgFmNyXQ9YxPBkNj_DLElVq1M-YHYx"
  @@API_HOST = "https://api.yelp.com"
  @@SEARCH_PATH = "/v3/businesses/search"
  @@BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path
  



  def home
    #Collect all necessary data and show them on home page.
    #This is the center of our app, so it should only serve for data displaying purpose.
    #and leave other functions to other methods that it calls.
    @user = load_user()
    #This @@Question_ID will be used on other method and should
    #be refreshed everytime we visited home page.
    #So we store it in a class varible
    #because every request(like GET '/home', to "users#home") will make rails to create a new instance of UserController.
    @@QUESTION_ID = Question.generate_question.id  
    @question = load_question(@@QUESTION_ID)
    @options = []
    for o in @question.options do
      @options.append(o["option"])
    end
    @businesses = yelp_business_search("", "New York", 9)
    @user_reviews = Review.get_user_reviews(@user.id)
    render "home"
  end



  def show   
    #Show user profile page, load user from session.
    #For editing user, we call edit method to do that.
    @user = load_user 
    render "show"
  end




  def edit
    #Edit user's personal information.
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




  def search
    #Search restaurant based on keyword(term) and location.
    #This is depended on Yelp business search end point.
    @user = load_user
    @from_other_page = !params[:commit].present?
    @TERM = ""  #term can be empty.
    if params[:term] != nil
      @TERM = params[:term]
    end

    @LOCATION = "" #location can not be empty.
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
    #This is our core recommend function.
    #We currently recommend restaurant by user's food preference keyword and the location we obtain from 
    #the Here Map API in Javascript.
    #And we will still use Yelp business search end point.

    #Before the project demo day, we play introduce redis caching into our project to cache user current preference
    #as well as some business user queried before(like two day before up to now).
    #So in this way, we can large reduce API calls to Yelp and in the meantime keep our site updated constantly. 
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




  def login
    #Login function.
    #User only need to login with email and password.
    #No other information is needed.
    #We want to keep this simple and focus on feature development on our project first.
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
      store_user(@user.id)  #if this user login successfully, we store his user_id into session. 
      redirect_to action: "home"   
    else
      render "welcome" #if he failed to login, he will keep stay at welcome page and receive login error
    end
  end





  def signup
    #Signup function
    #We only need the user to enter an email and password and re-enter password.

    #Before the project demo day, we will add email confirmation function into our project.
    #so that user can only use his/her valid email for registration. 
    #This largely enhances security level.
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

    if @signup_errors.length() > 0 # He failed to signup.
      render "welcome"
    else
      @new_user = User.create(email: @email, password_digest: @password)
      @new_user.save()
      store_user(@new_user.id) # If he successfully signed up, and we store his user_id into session.
      redirect_to action: "question", id:@new_user.id
    end
  end




  def question_update
    #Right after user successfully signed up, he will be directed to a simple food question page
    #so that we can store his food preference.
    #He can edit his food preference in the future on his user profile page.
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
      #We randomly select a question from our Question.all for user
      #This function will add more fun for user before we recommend restaurants to him. 
      return Question.find_by({id:@@QUESTION_ID})
    end

    def get_recommend(location)
      #This method is called by other public methods above.
      #It will recommend other 10 restaurant to our user.
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
