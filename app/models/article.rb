# frozen_string_literal: true

class Article < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :user 

  validates :title, presence: true
  validates :body, presence: true
end
