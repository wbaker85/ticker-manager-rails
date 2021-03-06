class Ticket < ApplicationRecord
  STATUS_LIST = %w(new blocked in_progress fixed)

  validates :name, presence: true
  validates :body, presence: true
  validates :project_id, presence: true
  validates :status, presence: true
  validate :valid_status

  def valid_status
    unless STATUS_LIST.include?(status)
      errors.add(:status, 'invalid status')
    end
  end

  belongs_to :project
  belongs_to :creator, class_name: 'User'
  belongs_to :assigned_to, class_name: 'User', optional: true

  has_many :tags_tickets, dependent: :destroy
  has_many :tags, through: :tags_tickets
  has_many :comments, dependent: :destroy
end
