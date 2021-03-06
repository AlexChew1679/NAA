require 'rails_helper'

  describe User, type: :model do
    describe 'validations' do

      before do
        @user = User.create(first_name: 'Alex', last_name: 'Chew', email: 'alex@alex.com', password: 'foobar', password_confirmation: 'foobar')
      end

      it 'can be created' do
      expect(@user).to be_valid
    end

    it 'cannot be created without a first name' do
      @user.first_name = nil
      expect(@user).not_to be_valid
    end

    it 'cannot be created without a last name' do
      @user.last_name = nil
      expect(@user).not_to be_valid
    end

    it 'cannot be created without a email' do
      @user.email = nil
      expect(@user).not_to be_valid
    end

    it 'cannot have a short first_name' do
      @user.first_name = 'a' * 2
      expect(@user).not_to be_valid
    end

    it 'cannot have a long first_name' do
      @user.first_name = 'a' * 25
      expect(@user).not_to be_valid
    end

    it 'cannot have a short last_name' do
          @user.last_name = 'a' * 2
          expect(@user).not_to be_valid
        end

    it 'cannot have a long last_name' do
          @user.last_name = 'a' * 25
          expect(@user).not_to be_valid
        end

    it 'cannot have an invalid address' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
    foo@bar_baz.com foo@bar+baz.com]

    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      expect(@user).not_to be_valid
      end
    end

    it 'must have a unique email address' do
      @user = User.new(first_name: 'Jane', last_name: 'Doe', email: 'ALEX@example.com')
      expect(@user).not_to be_valid
    end

    it 'must have a non blank password' do
      @user.password = @user.password_confirmation = ' ' * 6
      expect(@user).not_to be_valid
    end

    it 'must have a password with a minimum length' do
      @user.password = @user.password_confirmation = 'a' * 5
      expect(@user).not_to be_valid
    end

    it 'should return false for a user with nil digest' do
      expect(@user).not_to_be_valid if @user.authenticated?('')
    end



      end
      end
