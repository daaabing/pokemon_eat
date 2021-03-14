require 'rails_helper'
# --format documentation
require 'simplecov'
SimpleCov.start


RSpec.describe User, type: :model do
  context 'validation test' do
    it 'ensures password available' do
      user = User.new(email:'807442894@qq.com').save
      expect(user).to eq(false)
    end
    it 'ensures email available' do
      user = User.new(password_digest:'1').save
      expect(user).to eq(false)
    end
    it 'should be true' do
      user = User.new(email:'807442894@qq.com',password_digest:'1').save
      expect(user).to eq(true)
    end

    context 'scope test' do

    end
  end
end
