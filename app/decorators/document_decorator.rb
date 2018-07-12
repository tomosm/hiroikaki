# frozen_string_literal: true

# DocumentDecorator
class DocumentDecorator < ApplicationDecorator
  def contents
    elements.map(&:content)
  end
end
