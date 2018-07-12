# frozen_string_literal: true

namespace :document do
  desc 'perform document parser job for non-state documents'
  task perform_document_parser: :environment do
    Document.initial_state.find_each(&:perform_document_parser)
  end
end
