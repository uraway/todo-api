# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  access_token           :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validate' do

    it 'passes validation' do
      user = FactoryGirl.build(:user)
      expect(user).to be_valid
    end

    it 'fails validation when email is nil' do
      user = FactoryGirl.build(:user, email: nil)
      expect(user).to be_invalid
    end

    it 'fails validation when email is not unique' do
      FactoryGirl.create(:user)
      user = FactoryGirl.build(:user)
      expect(user).to be_invalid
    end
  end
end
