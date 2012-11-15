class Question < ActiveRecord::Base
  attr_accessible :poll_id, :question
  belongs_to :poll
  validate :unique_question


  def unique_question
    @question = Question.find_by_poll_id_and_question(self.poll_id, self.question)
    errors.add(:question, "You already wrote this question.") unless @question.nil?
  end
end
