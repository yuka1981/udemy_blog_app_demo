# frozen_string_literal: true

class Article < ApplicationRecord
  default_scope { order(created_at: :desc) }

  validates :title, presence: true
  validates :body, presence: true
end
