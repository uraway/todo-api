# == Schema Information
#
# Table name: todos
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  text       :text             default(""), not null
#  completed  :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'association' do
    it { should belong_to(:user) }
  end

  describe '#validate' do
    it 'passes validation' do
      todo = FactoryGirl.build(:todo)
      expect(todo).to be_valid
    end
  end
end
