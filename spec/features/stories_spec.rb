require 'spec_helper'

describe 'Stories' do

  subject { page }

  let(:admin) { FactoryGirl.create :admin }
  let(:user)  { FactoryGirl.create :user }

  describe 'writing' do

    let(:path) { new_story_path }

    describe 'permissions' do

      it { should_not allow_access.to(:guest) }
      it { should     allow_access.to(:user)  }
      it { should     allow_access.to(:admin) }

    end

    context 'when allowed' do

      before do
        login_as user
        visit path
      end

      it 'is linked from the navbar' do
        should have_css("a[href='#{ new_story_path }']")
      end

      it 'creates a new story' do
        # invalid data
        click_button 'Create'
        should have_content('Story was not successfully created!')

        # valid data
        fill_in_fields :story, title: 'Mah Sooper Blahg',
                               body:  'MOOOOOOO'

        click_button 'Create'
        should have_content('Story was successfully created!')
      end

    end

  end

  describe 'reading' do

    let(:story) { FactoryGirl.create :story }
    let(:path)  { story_path story }

    describe 'permissions' do

      it { should allow_access.to(:guest) }
      it { should allow_access.to(:user)  }
      it { should allow_access.to(:admin) }

    end

  end

end
