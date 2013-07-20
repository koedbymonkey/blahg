require 'spec_helper'

describe 'Welcome Page' do

  subject { page }

  let(:story) { FactoryGirl.create :story }


  describe 'View Stories' do
    before do
      visit root_path
    end

    it 'includes a story for guests' do
      should have_content(:story)
    end

  end


end
