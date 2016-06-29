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

class Todo < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :text, presence: true, length: { maximum: 255 }
  validates :completed, inclusion: { in: [true, false] }
end
