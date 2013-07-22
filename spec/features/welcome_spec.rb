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
        Timecop.travel(1.day.from_now)  { @first  = FactoryGirl.create :story, title: 'First' }
        Timecop.travel(2.days.from_now) { @second = FactoryGirl.create :story, title: 'Second' }
        Timecop.travel(3.days.from_now) { @third  = FactoryGirl.create :story, title: 'Third' }

        visit path
      end

      it 'includes all stories' do
        stories.map { |s| should have_css("##{ dom_id s }") }
      end

      it 'includes the title of each story' do
        stories.map { |s| within("##{ dom_id s }") { should have_content(s.title) }}
      end

      it 'includes the author name for each story' do
        stories.map { |s| within("##{ dom_id s }") { should have_content(s.author.username) }}
      end

      it 'includes the publication date for each story' do
        stories.map { |s| within("##{ dom_id s }") { should have_content(s.author.created_at.strftime '%Y-%m-%d') }}
      end

      it 'links to each story' do
        stories.map do |story|
          within("##{ dom_id story }") { should have_css("a[href='#{ story_path story }']", text: story.title) }
        end
      end

      it 'sorts stories reverse chronologically' do
        body.should match /Third.*Second.*First/m
      end

    end

  end

end
