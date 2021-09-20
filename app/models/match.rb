# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  score      :string
#  time       :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Match < ApplicationRecord
  has_many :match_players
  has_many :players, through: :match_players

  validates :time, presence: true
  validate :valid_score, unless: :score_blank?

  private

  def score_blank?
    self.score.blank?
  end

  def valid_score
    # format the string into integers
    score = self.score.split("-")

    # Throw an error if user enters letters instead of integers
    begin
      score[0] = Integer(score[0])
      score[1] = Integer(score[1])
    rescue
      errors.add(:score, "must contain '-' and numbers")
      return
    end

    score.sort!.reverse!
    if score[0] < 21
      errors.add(:score, "must have a winner with at least 21")
      return
    end

    if score[0] >= 21 && (score[0] - score[1]).abs < 2
      errors.add(:score, "must be within 2 points of each other")
      return
    end

    if score[0] > 21 && (score[0] - score[1]).abs > 2
      errors.add(:score, "must not be greater than 21")
      return
    end
  end
end
