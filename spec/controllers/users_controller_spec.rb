#******************************************


# We decide to drop this file because Rspec 4.0 Documentation officially suggest
# using request spec instead of controller spec test our controller.
# because they believe request spec take each request as an test object, instead of a controller method.
# We aggree on the to the point where each controller method usually has multiple purposes. 


#******************************************



# require 'simplecov'
# SimpleCov.start
# require 'rails_helper'
# # --format documentation

# describe UsersController do
#   describe "#login" do
#     before (:each) do
#       @user1 = User.create!(email: 'test@gmail.com', password_digest: 'test')
#       # @user2 = User.create!(email: '', password_digest: 'test')
#       # @user_new3 = User.create!(email: 'test@gmail.com', password_digest: '')
#       # @user_new4 = User.create!(email: 'test@gmail.com', password_digest: 'test1')
#       # @user_new5 = User.create!(email: 'testa@gmail.com', password_digest: 'test1')
#     end
#     describe "shouldn't input empty email" do
#       it "email not nil" do
#         # expect(@user_new1.email).to_not be_nil
#         (@user1.email).should_not be_blank
#       end
#       it "email nil" do
#         if "User.find_by(:email => "")".empty?
#           expect(response.body).to include "user does not exist, please register first"
#         end
#       end
#     end
#     describe "user shouldn't be nil do" do
#       it "email not nil" do
#         (User.find_by(:email => @user1.email)).should_not be_nil
#       end
#     end
#     describe "shouldn't input empty password" do
#       it "passsword not nil" do
#         (@user1.password_digest).should_not be_blank
#       end
#     end
#     describe "input valid email & password" do
#       it "passsword not nil" do
#         # (User.find_by(:email => @user1.email)).should_not be_nil
#         (User.find_by(:email => @user1.email, :password_digest => @user1.password_digest)).should_not be_nil
#       end
#     end
#   end

#   describe "#signup" do
#     before :each do
#       # @user1 = User.new
#       # @user1 = {
#       #   email =>'test@gmail.com',
#       #   password_digest => 'test',
#       #   re_password => 'test'
#       # }
#       @user1 = User.create!(email: 'test@gmail.com', password_digest: 'test')
#       @re_password1 = 'test'
#       @re_password2 = 'test1'
#       # params [ :email => @user1.email ]
#     end
#     describe "shouldn't input empty value" do
#       it "not nil" do
#         (@user1.email).should_not be_blank
#         (@user1.password_digest).should_not be_blank
#       end
#     end
#     describe "shouldn't input empty value" do
#       it "not nil" do
#         (@user1.email).should_not be_blank
#         (@user1.password_digest).should_not be_blank
#         if "User.find_by(:email => "") or User.find_by(:password_digest => "")".empty?
#           expect(response.body).to include "Password or re-password is empty!"
#         end
#       end
#     end
#     describe "password should = re_password" do
#       it "not nil" do
#         if "@user1.password_digest" == "@re_password"
#           expect(response).to have_http_status(:success)
#         end
#         # if "@user1.password_digest" != "@re_password2"
#         #   expect(response.body).to include "Password and Re-password do not match!"
#         # end
#       end
#     end
#   end
# end