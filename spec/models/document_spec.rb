# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document, type: :model do
  let(:document) { create :document }
  subject { document }

  describe 'check validations' do
    context 'when .url is not present' do
      let(:document) { build :document, url: '' }
      it { is_expected.to be_invalid }
    end

    context 'when .url is invalid url' do
      let(:document) { build :document, url: 'file://hogehogehoge' }
      it { is_expected.to be_invalid }
    end

    context 'when .status is not boolean' do
      let(:document) { build :document, status: '' }
      it { is_expected.to be_invalid }
    end
  end

  describe 'check functions' do
    context 'when .elements are present' do
      let(:document) { create :document, :after_parse }
      it { expect(document.elements.map(&:content)).to eq ['hoge'] }
    end

    context 'when .elements are empty' do
      it { expect(document.elements.map(&:content)).to eq [] }
    end
  end
end
