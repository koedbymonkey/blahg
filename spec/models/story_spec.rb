require 'spec_helper'

describe Story do

  describe 'validations' do
    
    it { should validate(:presence).of :author }
    it { should validate(:presence).of :body }
    it { should validate(:presence).of :title }
    
  end

end
