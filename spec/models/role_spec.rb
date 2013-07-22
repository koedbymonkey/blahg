require 'spec_helper'

describe Role do

  describe 'validations' do

    it { should validate(:presence).of :name }

    it { should validate(:uniqueness).of(:name).with case_sensitive: false }

  end

end
