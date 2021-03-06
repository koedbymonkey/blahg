require 'spec_helper'

describe 'Users' do

  subject { page }

  describe 'sign up' do

    before do
      visit new_user_registration_path
    end

    it 'creates a new account' do
      # invalid data
      click_button 'Sign up'
      should have_content('prohibited this user from being saved')

      # valid data
      fill_in_fields 'user', email:                 'moo@testing.com',
                             password:              'password123',
                             password_confirmation: 'password123',
                             username:              'Bukah'

      click_button 'Sign up'

      should have_content('A message with a confirmation link has been sent to your email address.')
    end

  end

end
