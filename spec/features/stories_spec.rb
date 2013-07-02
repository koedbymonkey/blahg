require 'spec_helper'

describe 'Stories' do

  subject { page }

  let(:admin) { FactoryGirl.create :admin }
  let(:user)  { FactoryGirl.create :user }

  describe 'writing' do

    describe 'permissions' do

      let(:path) { new_story_path }

      it { should_not allow_access.to(:guest) }
      it { should     allow_access.to(:user)  }
      it { should     allow_access.to(:admin) }

    end

  end

end
