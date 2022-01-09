# frozen_string_literal: true

class Article < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :user
  # when article has been deleted, the related comments also deleted
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
end
