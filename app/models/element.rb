# frozen_string_literal: true

# Element
class Element < ApplicationRecord
  belongs_to :document

  validates :document, :content, presence: true
end
