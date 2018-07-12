# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Element, type: :model do
  let(:element) { create :element }
  subject { element }

  describe 'check validations' do
    context 'when .content is not present' do
      let(:element) { build :element, content: '' }
      it { is_expected.to be_invalid }
    end

    context 'when .document_id is not present' do
      let(:element) { build :element, document_id: '' }
      it { is_expected.to be_invalid }
    end
  end
end
