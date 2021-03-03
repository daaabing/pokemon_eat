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

  #GET /search
  def search
    if params.has_key?("commit") == true
      render "search"
    end

    @TERM = "dinner"
    if params[:term] != nil
      @TERM = params[:term]
    end

    @LOCATION = "San Francisco, CA"
    if params[:location] != nil
      @LOCATION = params[:location]
    end

    @url = "#{@@API_HOST}#{@@SEARCH_PATH}"
    @params = {
      term: @TERM,
      location: @LOCATION,
      limit: 5
    }
    @response = HTTP.auth("Bearer #{@@API_KEY}").get(@url, params: @params)
    @response_body_hash = JSON.parse(@response.body)
    @businesses = @response_body_hash["businesses"]
    puts "------------"
    puts "is hash"
    puts @businesses[0].is_a? Hash
    puts "------------"
    render "search"
  end




  def login
    @email = params[:email]
    @password = params[:password]
    @user = User.find_by(email: @email)
    flash[:login_error] = []
    if @email == ""
      flash[:login_error].push("Empyt email!")
    end
    if @password == ""
      flash[:login_error].push("Empty password!")
    elsif @password != @user.password_digest
      flash[:login_error].push("Invalid password!")
    end

    if flash[:login_error].length() > 0
      puts flash[:login_error]
      render"pages/welcome"
    else
      redirect_to action: "show", id:@user.id
    end
  end



  def signup
    @email = params[:email]
    @password = params[:password]
    @re_password = params[:re_password]
    flash[:signup_error] = []
    if @email == ""
      flash[:signup_error].push("Empyt email!")
      # puts "Empyt email!"
    end
    if @password == "" or @re_password == ""
      flash[:signup_error].push("Empty password or re-password!")
      # puts "Empty password or re-password!"
    end
    if @password != @re_password
      flash[:signup_error].push("Password and Re-password do not match!")
      # puts "Password and Re-password do not match!"
    end
    if User.find_by(email: @email) != nil
      flash[:signup_error].push("This email has been registered!")
      # puts "This email has been registered!"
    end

    if flash[:signup_error].length() > 0
      puts flash[:signup_error]
      render"pages/welcome"
    else
      @new_user = User.create(email: @email, password_digest: @password)
      @new_user.save()
      flash[:signup_error] = nil
      redirect_to action: "show", id:@new_user.id
    end
  end


















  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show      
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :confirmed, :food_preference)
    end
end
