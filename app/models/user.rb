class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates :password_digest, presence: true

  def self.get_recommend(location)
    '''
    Get recommended restaurants for the user
    if user has food_preference, get 2 based on the preference and 1 randomly
    otherwise get 3 randomly
    input: location
    output: three restaurants
    '''
    # preference = User.find_by(id: id).food_preference   or
    @preference = User.find_by_id(1).food_preference
    @businesses = []
    if location
      @location = location
    else
      @location = 'NEW YORK'
    end
    if @preference == nil
      url = "https://api.yelp.com/v3/businesses/search"
      params = {
        term: @preference,
        location: @location,
        limit: 2
      }
      response = HTTP.auth("Bearer cOvuE6J1hqqbEn_ByZMHUqXod80KtPv55iLvQ6G9zoiFtbYvLNtpzUrHE9cFnP4-jTl-5ha99bTNYQ7LAtCWJ2FerNpFlRF9KVBgFmNyXQ9YxPBkNj_DLElVq1M-YHYx").get(url, params: params)
      response_body_hash = JSON.parse(response.body)
      @businesses.concat(response_body_hash["businesses"])
      url = "https://api.yelp.com/v3/businesses/search"
      params = {
        term: '',
        location: @location,
        limit: 1
      }
      response = HTTP.auth("Bearer cOvuE6J1hqqbEn_ByZMHUqXod80KtPv55iLvQ6G9zoiFtbYvLNtpzUrHE9cFnP4-jTl-5ha99bTNYQ7LAtCWJ2FerNpFlRF9KVBgFmNyXQ9YxPBkNj_DLElVq1M-YHYx").get(url, params: params)
      response_body_hash = JSON.parse(response.body)
      @businesses.concat(response_body_hash["businesses"])
      puts @businesses
    else
      url = "https://api.yelp.com/v3/businesses/search"
      params = {
        term: '',
        location: @location,
        limit: 3
      }
      response = HTTP.auth("Bearer cOvuE6J1hqqbEn_ByZMHUqXod80KtPv55iLvQ6G9zoiFtbYvLNtpzUrHE9cFnP4-jTl-5ha99bTNYQ7LAtCWJ2FerNpFlRF9KVBgFmNyXQ9YxPBkNj_DLElVq1M-YHYx").get(url, params: params)
      response_body_hash = JSON.parse(response.body)
      @businesses.concat(response_body_hash["businesses"])
    end
    @businesses
  end




end