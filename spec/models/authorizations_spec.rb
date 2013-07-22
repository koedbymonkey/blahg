require 'spec_helper'

describe Authorization do

  describe 'validations' do

    it { should validate(:presence).of :role_id }
    it { should validate(:presence).of :user_id }
    it { should validate(:uniqueness).of(:role_id).with scope: [:user_id] }
    it { should validate(:uniqueness).of(:user_id).with scope: [:role_id] }

  end

end
