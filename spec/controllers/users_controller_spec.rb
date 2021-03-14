require 'simplecov'
SimpleCov.start
require 'rails_helper'

describe UsersController do
    # describe "#search" do
    #
    #   before do
    #
    #   end
    #
    #   describe "come from other page" do
    #
    #   end
    #
    #   describe "did not input loaction, which causes search error" do
    #
    #   end
    #
    #   describe "input location, everything works fine" do
    #
    #   end
    # end

    describe "#login" do
      before (:each) do
        @user_new1 = User.find_by(id ='1')
        # @user_new2 = User.create!(email: '', password_digest: 'test')
        # @user_new3 = User.create!(email: 'test@gmail.com', password_digest: '')
        # @user_new4 = User.create!(email: 'test@gmail.com', password_digest: 'test1')
        # @user_new5 = User.create!(email: 'testa@gmail.com', password_digest: 'test1')
      end
      describe "shouldn't input empty email" do
        it "not nil" do
          expect(@user_new1.email).to_not be_nil
        end
      end
      # describe "user shouldn't be nil do" do
      #
      # end
      # describe "shouldn't input empty password" do
      #
      # end
      # describe "input valid email & password" do
      #
      # end
    end
end