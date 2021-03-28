require 'rails_helper'

RSpec.describe "Businesses", type: :request do
    before(:each) do
        @user_new = User.create!(email: 'test122@gmail.com', password_digest: 'test')
        post "/login", :params => {:email => 'test122@gmail.com', :password =>'test' }
    end

    it "check get on restaurant detail page successfully" do
        get '/business/H4jJ7XB3CetIr1pg56CczQ'
        expect(response).to have_http_status(200)
    end

    it "check get on restaurant review page successfully" do 
        get '/business/JV5oa5-KGdiWnqrKPoxSug/review'
        expect(response).to have_http_status(200)
    end

    it "check get on event list page with location input successfully" do
        get '/events/?location=50+W+108th+St%2C+New+York%2C+NY+10025-3243%2C+United+States&commit=Find'
        expect(response).to have_http_status(200)
    end

    it "check get on event list page with default location  successfully" do
        get '/events'
        expect(response).to have_http_status(200)
    end

    it "check get event detail page successfully" do 
        get '/event/astoria-yelps-spring-spectacle'
        expect(response).to have_http_status(200)
    end

    it "check get on restaurant review page and write a review successfully" do 
        get '/business/JV5oa5-KGdiWnqrKPoxSug/review?review=this+restaurant+is+great%21&commit=Post'
        expect(response).to have_http_status(302)
    end
    
end
