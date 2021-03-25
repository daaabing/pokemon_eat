class BusinessesController < ApplicationController
  @@API_KEY = "cOvuE6J1hqqbEn_ByZMHUqXod80KtPv55iLvQ6G9zoiFtbYvLNtpzUrHE9cFnP4-jTl-5ha99bTNYQ7LAtCWJ2FerNpFlRF9KVBgFmNyXQ9YxPBkNj_DLElVq1M-YHYx"
  @@API_HOST = "https://api.yelp.com"
  @@SEARCH_PATH = "/v3/businesses/"


  

  def show
    @user = load_user()
    @business_id = params[:business_id]
    @business = yelp_business_detail(@business_id)
    @reviews = Review.where(business_id:@business_id)
    
  end





  def review
    @user_id =  session[:user_id]
    @business_id = params[:business_id]
    puts @business_id
    @business = yelp_business_detail(@business_id)
    puts "*************"
    puts @business
    puts "*************"
    if params[:commit] == "Post"
      review = params[:review]
      new_review = Review.create({user_id: @user_id, business_id: @business_id, review: review})
      new_review.save
      redirect_to "/business/" + @business_id
    end
  end



  private
    def yelp_business_detail(business_id)
      url = "#{@@API_HOST}#{@@SEARCH_PATH}#{business_id}"
      response = HTTP.auth("Bearer #{@@API_KEY}").get(url)
      response_body_hash = JSON.parse(response.body)
      return response_body_hash
    end

    def store_user(id)
      session[:user_id] = id
    end
    
    def load_user
      return User.find_by({id:session[:user_id]})
    end
end
