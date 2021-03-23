require "json"
require "http"
require "optparse"


class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  @@API_KEY = "cOvuE6J1hqqbEn_ByZMHUqXod80KtPv55iLvQ6G9zoiFtbYvLNtpzUrHE9cFnP4-jTl-5ha99bTNYQ7LAtCWJ2FerNpFlRF9KVBgFmNyXQ9YxPBkNj_DLElVq1M-YHYx"
  @@API_HOST = "https://api.yelp.com"
  @@SEARCH_PATH = "/v3/businesses/search"
  @@BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path
  @@DEFAULT_BUSINESS_ID = "yelp-san-francisco"
  @@EVENT_PATH = "/v3/events"

  def search
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
      url = "#{@@API_HOST}#{@@SEARCH_PATH}"
      params = {
        term: @TERM,
        location: @LOCATION,
        limit: 5
      }
      response = HTTP.auth("Bearer #{@@API_KEY}").get(url, params: params)
      response_body_hash = JSON.parse(response.body)
      @businesses = response_body_hash["businesses"]
    else
    end
    puts "**************"
    puts @businesses[0]
    puts "**************"
    render "search"
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
      redirect_to action: "home", id:@user.id      
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
        redirect_to action: "question", id:@new_user.id
      else
        @signup_errors.push("Sorry, signing up failed somehow, please try again.")
        render "welcome"
      end
    end
  end



















  def show    
  end

  def home
    # @TERM = ""
    # if params[:term] != nil
    #   @TERM = params[:term]
    # end

    # @LOCATION = "New York"
    # @search_error = nil
    # if params[:location].present?
    #   @LOCATION = params[:location]
    # else
    #   @search_error = "location can not be empty!"
    # end

    @businesses = []
    if @search_error == nil
      url = "#{@@API_HOST}#{@@SEARCH_PATH}"
      params = {
        term: @TERM,
        location: "New York",
        limit: 10
      }
      response = HTTP.auth("Bearer #{@@API_KEY}").get(url, params: params)
      response_body_hash = JSON.parse(response.body)
      @businesses = response_body_hash["businesses"]
    else
    end
    puts "**************"
    puts @businesses[0]
    puts "**************"
    render "home"
  end





  def question
    # @user = User.find(params[:id])
  end
  
  def question_update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to action: "home", id:@user.id, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:email, :password, :password_confirmation, :confirmed, :food_preference)
    end
    #
    # def store_cookie(id, email, password)
    #   session[:user_id] = id
    #   session[:user_email] = email
    #   session[:user_password] = password
    # end
    #
    # def load_cookie
    #   return User.find_by({id:session[:user_id],email:session[:user_email],password_digest:session[:user_password]})
    # end
end
