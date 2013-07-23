require 'spec_helper'

describe User do

  describe 'validations' do

    it { should validate(:presence).of :username }
    it { should validate(:uniqueness).of :username }

  end

  describe 'roles' do

    let(:user) { FactoryGirl.create :user }

    it 'gets the role "Commenter" by default' do
      user.should have_role(:commenter)
    end

  end

end
