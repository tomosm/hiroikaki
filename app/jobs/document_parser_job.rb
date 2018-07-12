# frozen_string_literal: true

# DocumentParserJob
class DocumentParserJob < ApplicationJob
  def perform(document_id)
    logger.info("[FIND] document_id: #{document_id}")
    document = Document.initial_state.find_by(id: document_id)
    return false if document.nil?

    logger.info("[START] document_id: #{document_id}")
    document.scan_contents
    logger.info("[END] document_id: #{document_id}")
    true
  end
end
