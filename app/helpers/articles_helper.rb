# frozen_string_literal: true

module ArticlesHelper
  def persisted_comments(comments)
    # comments.reject { |comment| comment.new_record? }
    # filters out any comments that has not yet been saved to the database, then calls each on that.
    # reference: https://www.ruby-forum.com/t/can-you-explain-reject-new-record/186545/2
    comments.reject(&:new_record?)
  end
end
