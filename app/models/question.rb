class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  scope :recent, -> { order(created_at: :desc) }

  before_validation :set_solved_value

  validates :title, presence: true
  validates :body, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[title]
  end

  def self.ransackable_associations(auth_object = nul)
    []
  end

  private

  def set_solved_value
    if solved.present?
      self.solved = true
    else
      self.solved = false
    end
  end
end
