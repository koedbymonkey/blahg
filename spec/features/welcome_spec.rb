require 'spec_helper'

describe 'Welcome' do

  subject { page }

  let(:path) { root_path }

  before do
    visit path
  end

  describe 'permissions' do

    it { should allow_access.to(:guest) }

  end

  describe 'when allowed' do

    include ActionController::RecordIdentifier

    describe 'View Stories' do
      let(:stories) { Story.all }

      before do
        FactoryGirl.create_list :story, 3
        visit path
      end

      it 'includes all stories' do
        stories.map { |s| should have_css("##{ dom_id s }") }
      end

    end

  end

end
