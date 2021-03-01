require "json"
require "http"
require "optparse"


class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]




  def search
    @API_KEY = "YzXFUy2VurAbmBHqBTiZwRC9Mx5rTGHkaZs5Jv-_V2K4BpLCtv0ucQOlT7slIGGHU2I8r-5kUDgJ0c6k5I1BYtPHWvCAV0n7DetPpKrxHhYcq6Dcku8FdJjA9o87YHYx"
    @API_HOST = "https://api.yelp.com"
    @SEARCH_PATH = "/v3/businesses/search"
    @BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path


    @DEFAULT_BUSINESS_ID = "yelp-san-francisco"
    @DEFAULT_TERM = "dinner"
    @DEFAULT_LOCATION = "San Francisco, CA"
    @SEARCH_LIMIT = 5
    url = "#{@API_HOST}#{@SEARCH_PATH}"
    params = {
      term: "seafood",
      location: "New York",
      limit: @SEARCH_LIMIT
    }
    response = HTTP.auth("Bearer #{@API_KEY}").get(url, params: params)
    puts response
  end




  def login
    @email = params[:address]
    @password = params[:password]
    if User.find_by(email: @email, password_digest: @password) != nil 
      redirect_to "http://www.google.com"
    end
  end

  def signup
    @email = params[:address]
    @password = params[:password]
    if User.find_by(email: @email) != nil #buggy!!!
      flash[:registered] = "This email has been registered."
    else
      @new_user = User.create(email: @email, password_digest: @password)
      @new_user.save()
      redirect_to "http://www.google.com"
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
