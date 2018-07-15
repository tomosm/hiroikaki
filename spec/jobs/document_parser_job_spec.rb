# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DocumentParserJob, type: :job do
  it 'enqueues a job' do
    ActiveJob::Base.queue_adapter = :test
    DocumentParserJob.perform_later
    expect(DocumentParserJob).to have_been_enqueued
  end

  describe '#perform' do
    context 'document is present' do
      let(:document) { create :document }
      before do
        Document.any_instance.should_receive(:scan_contents)
      end
      it { expect(DocumentParserJob.perform_now(document.id)).to be_truthy }
    end

    context 'error occurs during scanning' do
      let(:document) { create :document }
      before do
        Document.any_instance.should_receive(:scan_contents) { raise StandardError }
      end
      it { expect(DocumentParserJob.perform_now(document.id)).to be_falsey }
    end

    context 'document is not present' do
      it { expect(DocumentParserJob.perform_now(nil)).to be_falsey }
    end
  end
end
