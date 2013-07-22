require 'spec_helper'

describe User do

  describe 'validations' do

    it { should validate(:presence).of :username }

  end

end
