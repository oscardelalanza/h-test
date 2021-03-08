class Owner < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  TIME_LIMIT_START = Time.parse('08:00')
  TIME_LIMIT_END = Time.parse('20:00')

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :jwt_authenticatable, jwt_revocation_strategy: self
  validates :name, presence: true, length: { maximum: 255 }
  validates :available_day, presence: true, length: { maximum: 9 },
                            inclusion: { in: %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday] }
  validates :hour_start, presence: true, format: { with: /((2[0-3])|(1[0-9])|(0[0-9])):([0-5][0-9])/ }
  validates :hour_end, presence: true, format: { with: /((2[0-3])|(1[0-9])|(0[0-9])):([0-5][0-9])/ }
  validates :phone, presence: true, numericality: true, length: { minimum: 10, maximum: 10 }, uniqueness: true
  validate :hour_start_validator
  validate :hour_end_validator

  private

  def time_converter(time)
    Time.parse(time)
  rescue StandardError
    nil
  end

  def hour_start_validator
    return unless hour_start

    scheduled = time_converter(hour_start)
    return unless scheduled

    errors.add(:hour_start, 'Out of permitted time') if (TIME_LIMIT_START > scheduled) || (TIME_LIMIT_END < scheduled)
  end

  def hour_end_validator
    return unless hour_end

    start = time_converter(hour_start)
    scheduled = time_converter(hour_end)
    return unless scheduled
    return unless start.is_a? Time

    errors.add(:hour_end, 'Out of permitted time') if TIME_LIMIT_START > scheduled || TIME_LIMIT_END < scheduled
  end
end
