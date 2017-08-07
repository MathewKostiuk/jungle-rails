require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should be valid when everything is valid' do
      @user = User.create({
        first_name: 'name',
        last_name: 'name',
        email: 'john@doe.com',
        password: '123456',
        password_confirmation: '123456'
        })
      expect(@user).to be_valid
    end
    it 'should be invalid when name is missing' do
      @user = User.create({
        last_name: 'name',
        email: 'john@doe.com',
        password: '123456',
        password_confirmation: '123456'
        })
      expect(@user.errors.messages[:first_name]).to include("is too short (minimum is 2 characters)")
    end
    it 'should be invalid when email is not unique' do
      @user = User.create({
        first_name: 'name',
        last_name: 'name',
        email: 'JOHN@doe.com',
        password: '123456',
        password_confirmation: '123456'
        })
       @user1 = User.create({
        first_name: 'name',
        last_name: 'name',
        email: 'john@DOE.com',
        password: '123456',
        password_confirmation: '123456'
        })
      expect(@user1).to_not be_valid
    end
    it 'should be invalid when password and password confirmation dont match' do
       @user = User.create({
        first_name: 'name',
        last_name: 'name',
        email: 'john@doe.com',
        password: '123456',
        password_confirmation: '124456'
        })
      expect(@user.errors.messages[:password_confirmation]).to include("doesn't match Password")
    end
    it 'should be invalid when last name is not present' do
      @user = User.create({
        first_name: 'name',
        email: 'john@doe.com',
        password: '123456',
        password_confirmation: '123456'
        })
      expect(@user.errors.messages[:last_name]).to include("is too short (minimum is 2 characters)")
    end
  end
end
