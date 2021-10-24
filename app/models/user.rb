class User < ApplicationRecord
  mount_uploader :avater, AvaterUploader
  has_secure_password
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  before_validation :set_admin_false

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  private

  def set_admin_false
    self.admin = false if admin.blank?
  end
end
