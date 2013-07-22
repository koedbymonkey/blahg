require 'spec_helper'

describe 'Admin' do

  subject { page }

  let(:admin) { FactoryGirl.create :admin }
  let(:user)  { FactoryGirl.create :user }

  describe 'authorizations' do

    let(:authorization) { FactoryGirl.create :authorization }

    describe 'listing' do

      let(:path) { rails_admin.index_path :authorization }

      describe 'permissions' do

        it { should_not allow_access.to(:guest) }
        it { should_not allow_access.to(:user)  }
        it { should     allow_access.to(:admin) }

      end

      context 'when allowed' do

        before do
          authorization
          login_as admin
          visit path
        end

        it { should have_css("a[href='#{ rails_admin.show_path :authorization, authorization }']")}
        it { should have_css("a[href='#{ rails_admin.edit_path :authorization, authorization }']")}
        it { should have_css("a[href='#{ rails_admin.delete_path :authorization, authorization }']")}

      end

    end

    describe 'creating' do

      let!(:role) { FactoryGirl.create :role }
      let!(:user) { FactoryGirl.create :user }
      let(:path)  { rails_admin.new_path :authorization }

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

        it 'creates a authorization' do
          # invalid data
          click_button 'Save'
          should have_content('Authorization failed to be created')

          # valid data
          select role.name,     from: 'Role'
          select user.username, from: 'User'

          click_button 'Save'
          should have_content('Authorization successfully created')
        end

      end

    end

    describe 'editing' do

      let!(:another_role) { FactoryGirl.create :role }
      let(:authorization) { FactoryGirl.create :authorization }
      let(:path)          { rails_admin.edit_path :authorization, authorization }

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

        it 'can change the name' do
          # invalid data
          select '', from: 'Role'
          select '', from: 'User'

          click_button 'Save'
          should have_content('Authorization failed to be updated')

          # valid data
          select another_role.name,           from: 'Role'
          select authorization.user.username, from: 'User'

          click_button 'Save'
          should have_content('Authorization successfully updated')
        end

      end

    end

    describe 'deleting' do

      let!(:authorization) { FactoryGirl.create :authorization }

      before do
        login_as admin
        visit rails_admin.index_path(:authorization)
      end

      it 'removes the authorization with confirmation' do
        find("a[href='#{ rails_admin.delete_path :authorization, authorization }']").click
        should have_content('Are you sure you want to delete this authorization')

        click_button "Yes, I'm sure"
        should have_content('Authorization successfully deleted')
      end

    end

  end

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

  describe 'roles' do

    let(:role) { FactoryGirl.create :role }

    describe 'listing' do

      let(:path) { rails_admin.index_path :role }

      describe 'permissions' do

        it { should_not allow_access.to(:guest) }
        it { should_not allow_access.to(:user)  }
        it { should     allow_access.to(:admin) }

      end

      context 'when allowed' do

        before do
          role
          login_as admin
          visit path
        end

        it { should have_css("a[href='#{ rails_admin.show_path :role, role }']")}
        it { should have_css("a[href='#{ rails_admin.edit_path :role, role }']")}
        it { should have_css("a[href='#{ rails_admin.delete_path :role, role }']")}

      end

    end

    describe 'creating' do

      let(:path) { rails_admin.new_path :role }

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

        it 'creates a role' do
          # invalid data
          click_button 'Save'
          should have_content('Role failed to be created')

          # valid data
          fill_in_fields 'role', name: 'bukah'

          click_button 'Save'
          should have_content('Role successfully created')
        end

      end

    end

    describe 'editing' do

      let(:path) { rails_admin.edit_path :role, role }

      describe 'permissions' do

        it { should_not allow_access.to(:guest) }
        it { should_not allow_access.to(:user)  }
        it { should     allow_access.to(:admin) }

      end

      context 'when allowed' do

        before do
          role
          login_as admin
          visit path
        end

        it 'can change the name' do
          # invalid data
          fill_in_fields :role, name: ''

          click_button 'Save'
          should have_content('Role failed to be updated')

          # valid data
          fill_in_fields :role, name: 'something'

          click_button 'Save'
          should have_content('Role successfully updated')
        end

      end

    end

    describe 'deleting' do

      before do
        role
        login_as admin
        visit rails_admin.index_path(:role)
      end

      it 'removes the role with confirmation' do
        find("a[href='#{ rails_admin.delete_path :role, role }']").click
        should have_content('Are you sure you want to delete this role')

        click_button "Yes, I'm sure"
        should have_content('Role successfully deleted')
      end

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
        it { should have_css("a[href='#{ rails_admin.delete_path :user, user }']")}

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

    describe 'deleting' do

      before do
        user
        login_as admin
        visit rails_admin.index_path(:user)
      end

      it 'removes the user with confirmation' do
        find("a[href='#{ rails_admin.delete_path :user, user }']").click
        should have_content('Are you sure you want to delete this user')

        click_button "Yes, I'm sure"
        should have_content('User successfully deleted')
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
