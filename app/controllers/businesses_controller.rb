class BusinessesController < ApplicationController
  @@API_KEY = "cOvuE6J1hqqbEn_ByZMHUqXod80KtPv55iLvQ6G9zoiFtbYvLNtpzUrHE9cFnP4-jTl-5ha99bTNYQ7LAtCWJ2FerNpFlRF9KVBgFmNyXQ9YxPBkNj_DLElVq1M-YHYx"
  @@API_HOST = "https://api.yelp.com"
  @@SEARCH_PATH = "/v3/businesses/"
  @@EVENT_PATH = "/v3/events"



  

  def show
    @user = load_user()
    @business_id = params[:business_id]
    @business = yelp_business_detail(@business_id)
    @reviews = Review.where(business_id:@business_id)
  end





  def review
    @user_id = session[:user_id]
    @business_id = params[:business_id]
    puts @business_id
    @business = yelp_business_detail(@business_id)
    if params[:commit] == "Post"
      review = params[:review]
      new_review = Review.create({user_id: @user_id, business_id: @business_id, review: review})
      new_review.save
      redirect_to "/business/" + @business_id
    end
  end





  def get_event_list
    @user = load_user
    @LOCATION = ""
    if params[:location].present?
      @LOCATION = params[:location]
    else
      @LOCATION = "New York"
    end
    @events = yelp_event_search(@LOCATION)
    render "events"
  end





  def get_event
    @user = load_user
    @event_id = params[:id]
    @event = yelp_event_lookup(@event_id)
    render "event"
  end





  private
    def yelp_business_detail(business_id)
      url = "#{@@API_HOST}#{@@SEARCH_PATH}#{business_id}"
      response = HTTP.auth("Bearer #{@@API_KEY}").get(url)
      response_body_hash = JSON.parse(response.body)
      return response_body_hash
    end





    def yelp_event_search(location)
      url = "#{@@API_HOST}#{@@EVENT_PATH}"
      puts "url"
      puts url
      params = {
        location: location,
        limit: 10
      }
      response = HTTP.auth("Bearer #{@@API_KEY}").get(url, params: params)
      response_body_hash = JSON.parse(response.body)
      events = response_body_hash["events"]
      return events
    end




    def yelp_event_lookup(event_id)
      url = "#{@@API_HOST}#{@@EVENT_PATH}/#{event_id}"
      puts "url"
      puts url
      response = HTTP.auth("Bearer #{@@API_KEY}").get(url)
      event = JSON.parse(response.body)
      puts "**************"
      puts event
      puts "**************"
      return event
    end





    def store_user(id)
      session[:user_id] = id
    end
    



    def load_user
      return User.find_by({id:session[:user_id]})
    end
end
