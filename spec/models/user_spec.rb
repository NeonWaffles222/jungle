require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    before :each do
      @user = User.new(first_name: 'Jimmy', last_name: 'Jones', email: 'jimmyJ@gmail.com', password: 'password123', password_confirmation: 'password123')
    end

    it 'should have matching password and password_confirmation' do 
      @user.password = 'wordpass234'
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should require a password' do
      @user.password = nil
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should require a unique email and not be case sensitive' do 
      @user.save
      user2 = User.create(first_name: 'John', last_name: 'James', email: 'JImMyj@gMAiL.cOm', password: 'password123', password_confirmation: 'password123')
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should require a email' do
      @user.email = nil
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should require a first name' do
      @user.first_name = nil
      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    
    it 'should require a last name' do
      @user.last_name = nil
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should require a minimum password length of 10 characters' do
      @user.password = 'password'
      @user.password_confirmation = 'password'
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 10 characters)")
    end
  end
end

describe '.authenticate_with_credentials' do

  before :each do
    @user = User.new(first_name: 'Jimmy', last_name: 'Jones', email: 'jimmyJ@gmail.com', password: 'password123', password_confirmation: 'password123')
  end

  it 'should not authenticate with a invalid email' do
    @user.save
    expect(User.authenticate_with_credentials('billy@hotmail.com', 'password123')).to be_nil
  end

  it 'should not authenticate with a invalid password' do
    @user.save
    expect(User.authenticate_with_credentials('jimmyJ@gmail.com', 'password123456')).to be_nil
  end

  it 'should ignore whitespace in email when authenticating' do
    @user.save
    expect(User.authenticate_with_credentials('  jimmyJ@gmail.com ', 'password123')).to eq(@user)
  end

  it 'should ignore case in email when authenticating' do
    @user.save
    expect(User.authenticate_with_credentials('JImMyj@gMAiL.cOm', 'password123')).to eq(@user)
  end
end
