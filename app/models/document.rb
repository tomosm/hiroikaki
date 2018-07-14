# frozen_string_literal: true

# Document
class Document < ApplicationRecord
  include AASM
  include FilterElements

  has_many :elements, dependent: :destroy

  scope :initial_state, -> { where(status: Document.statuses[:initial]) }

  validates :url, url: true
  validates :status, presence: true

  after_create :perform_document_parser
  before_update :update_document_parser
  after_update :perform_document_parser

  enum status: {
    initial:  0,
    scanning: 1,
    success:  2,
    failure:  3
  }

  aasm column: :status, enum: true do
    state :initial, initial: true
    state :scanning, :success, :failure

    event :proceed do
      transitions from: :initial, to: :scanning
    end

    event :succeed do
      transitions from: :scanning, to: :success
    end

    event :fail do
      transitions from: :scanning, to: :failure
    end

    event :reset do
      transitions from: %i[initial success failure], to: :initial
    end
  end

  def scan_contents
    proceed!
    contents = scan(url)
    contents.each do |content|
      elements.create(content: content)
    end
    success!
  rescue StandardError => e
    failure!
    raise e
  end

  def perform_document_parser
    DocumentParserJob.perform_later id
  end

  private

  def update_document_parser
    return unless url_changed?
    elements.destroy_all
    reset
  end
end
