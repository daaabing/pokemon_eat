class BusinessesController < ApplicationController
  @@API_KEY = "cOvuE6J1hqqbEn_ByZMHUqXod80KtPv55iLvQ6G9zoiFtbYvLNtpzUrHE9cFnP4-jTl-5ha99bTNYQ7LAtCWJ2FerNpFlRF9KVBgFmNyXQ9YxPBkNj_DLElVq1M-YHYx"
  @@API_HOST = "https://api.yelp.com"
  @@SEARCH_PATH = "/v3/businesses/"
  @@EVENT_PATH = "/v3/events"

  def show
    #Show a specific business detail page
    @user = load_user()
    @business_id = params[:business_id]
    @business = yelp_business_detail(@business_id)
    @reviews = Review.where(business_id:@business_id)
    @categories = @business["categories"]
    puts "*******"
    puts @categories
    puts "*******"
  end

  def review
    #It finish one of the two things at each method call:
    #1. If this user did not press Post button, it renders business/review.html.erb
    #2. If this user pressed Post button, it store users reivew into Review table and get back to 
    #   reataurant detail that this reivew was created for.
    @user_id = session[:user_id]
    @business_id = params[:business_id]
    @business = yelp_business_detail(@business_id)
    if params[:commit] == "Post"
      review = params[:review]
      new_review = Review.create({user_id: @user_id, business_id: @business_id, review: review})
      new_review.save
      redirect_to "/business/" + @business_id
    end
  end

  def get_event_list
    #Show the event list page after searching one location's popular events.
    @user = load_user
    @LOCATION = ""
    if params[:location].present?
      @LOCATION = params[:location]
    else
      @LOCATION = "New York"#default location is New York
    end
    @events = yelp_event_search(@LOCATION)
    render "events"
  end

  def get_event
    #On the event list page, if current user is interested in any particular event,
    #he will get the event detail on business/event.html.erb
    @user = load_user
    @event_id = params[:id]
    puts "*******"
    puts @event_id
    puts "*******"
    @event = yelp_event_lookup(@event_id)
    render "event"
  end

  def like_res
    @user = load_user
    @business_id = params[:business_id]
    Like.like_this_res(@business_id, @user.id)
    redirect_to "/business/" + @business_id.to_s
  end

  def book_event
    @user = load_user
    @event_id = params[:event_id]
    BookedEvent.book_this_event(@event_id, @user.id)
    redirect_to "/event/" + @event_id
  end



  private

    def yelp_business_detail(business_id)
      #Calling Yelp business search end point
      url = "#{@@API_HOST}#{@@SEARCH_PATH}#{business_id}"
      response = HTTP.auth("Bearer #{@@API_KEY}").get(url)
      response_body_hash = JSON.parse(response.body)
      return response_body_hash
    end

    def yelp_event_search(location)
      #Calling Yelp event search end point, get a list of events at one location.
      url = "#{@@API_HOST}#{@@EVENT_PATH}"
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
      #Caling Yelp event look up end point.
      url = "#{@@API_HOST}#{@@EVENT_PATH}/#{event_id}"
      response = HTTP.auth("Bearer #{@@API_KEY}").get(url)
      event = JSON.parse(response.body)
      return event
    end
    
    def load_user
      return User.find_by({id:session[:user_id]})
    end

end
