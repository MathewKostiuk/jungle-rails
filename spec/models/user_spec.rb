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
    it 'should be invalid when password is below 3 characters' do
      @user = User.create({
        first_name: 'name',
        last_name: 'name',
        email: 'john@doe.com',
        password: '12',
        password_confirmation: '12'
        })
      expect(@user.errors.messages[:password]).to include("is too short (minimum is 3 characters)")
    end
  end
  describe '.authenticate_with_credentails' do
    it 'should return an instance of a user' do
      expect(User.authenticate_with_credentials("john@doe.com", '123456')).to eq(User.find_by_email('john@doe.com'))
    end
    it 'should return nil when email is invalid' do
      expect(User.authenticate_with_credentials("best@test.com", '123456')).to eq(nil)
    end
    it 'should return an instance of a user when accidental spaces are inputed' do
      expect(User.authenticate_with_credentials("   john@doe.com   ", '123456')).to eq(User.find_by_email('john@doe.com'))
    end
    it 'should return an instance of a user when case is wrong' do
      expect(User.authenticate_with_credentials("JoHn@dOe.com", '123456')).to eq(User.find_by_email('john@doe.com'))
    end
  end
end
