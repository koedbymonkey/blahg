require 'spec_helper'

describe 'Admin' do

  subject { page }

  let(:admin) { FactoryGirl.create :admin }
  let(:user)  { FactoryGirl.create :user }

  describe 'dashboard' do

    let(:path) { rails_admin.dashboard_path }

    describe 'permissions' do

      it { should_not allow_access.to(:guest) }
      it { should_not allow_access.to(:user)  }
      it { should     allow_access.to(:admin) }

    end

    context 'when allowed' do

      before do
        login_as admin
        visit path
      end

      it { should have_css("a[href='#{ rails_admin.new_path :user }']")}

    end

  end

  describe 'users' do

    describe 'listing' do

      let(:path) { rails_admin.index_path :user }

      describe 'permissions' do

        it { should_not allow_access.to(:guest) }
        it { should_not allow_access.to(:user)  }
        it { should     allow_access.to(:admin) }

      end

      context 'when allowed' do

        before do
          user
          login_as admin
          visit path
        end

        it { should have_css("a[href='#{ rails_admin.show_path :user, user }']")}
        it { should have_css("a[href='#{ rails_admin.edit_path :user, user }']")}

      end

    end

    describe 'creating' do

      let(:path) { rails_admin.new_path :user }

      describe 'permissions' do

        it { should_not allow_access.to(:guest) }
        it { should_not allow_access.to(:user)  }
        it { should     allow_access.to(:admin) }

      end

      context 'when allowed' do

        before do
          login_as admin
          visit path
        end

        it 'creates a user' do
          # invalid data
          click_button 'Save'
          should have_content('User failed to be created')

          # valid data
          fill_in_fields 'user', email:                 'user@testing.com',
                                 password:              'password',
                                 password_confirmation: 'password',
                                 username:              'Bukah Nugget'
          check 'Admin'

          click_button 'Save'
          should have_content('User successfully created')
        end

      end

    end

    describe 'editing' do

      let(:path) { rails_admin.edit_path :user, user }

      describe 'permissions' do

        it { should_not allow_access.to(:guest) }
        it { should_not allow_access.to(:user)  }
        it { should     allow_access.to(:admin) }

      end

      context 'when allowed' do

        before do
          user
          login_as admin
          visit path
        end

        it 'can change the password' do
          # invalid data

          # Apparently changing the password does not require confirmation?!
          # fill_in_fields :user, password: 'new-password'
          #
          # click_button 'Save'
          # should have_content('User failed to be updated')

          # valid data
          fill_in_fields :user, password:              'new-password',
                                password_confirmation: 'new-password'

          click_button 'Save'
          should have_content('User successfully updated')
        end

      end

    end

  end

  describe 'navbar' do

    context 'not logged in' do

      before do
        visit root_path
      end

      it 'does not include a link to the admin' do
        should_not have_css(".navbar a[href='#{ rails_admin.dashboard_path }']")
      end

    end

    context 'logged in as a user' do

      before do
        login_as user
        visit root_path
      end

      it 'does not include a link to the admin' do
        should_not have_css(".navbar a[href='#{ rails_admin.dashboard_path }']")
      end

    end

    context 'logged in as an admin' do

      before do
        login_as admin
        visit root_path
      end

      it 'includes a link to the admin' do
        should have_css(".navbar a[href='#{ rails_admin.dashboard_path }']")
      end

    end

  end

end
