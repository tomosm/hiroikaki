# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FilterElements do
  class FilterElementsTest
    include FilterElements
  end
  let(:testee) { FilterElementsTest.new }

  describe 'check functions' do
    describe '#scan' do
      context 'when Hiroiyomi#read returns data' do
        before do
          data = [
            Hiroiyomi::Html::Element.new('h1'),
            Hiroiyomi::Html::Element.new('h2', children: [Hiroiyomi::Html::Text.new('h2_content')]),
            Hiroiyomi::Html::Element.new('p', children: [Hiroiyomi::Html::Text.new('h_content')]),
            Hiroiyomi::Html::Element.new('a', attributes: [Hiroiyomi::Html::Attribute.new('href')]),
            Hiroiyomi::Html::Element.new('a', attributes: [Hiroiyomi::Html::Attribute.new('href', '/aboutme')])
          ]
          allow(Hiroiyomi).to receive(:read).and_return(data)
        end
        it do
          actual = testee.scan('https://hiroikaki.herokuapp.com')
          expect(actual.length).to eq 2
          expect(actual.sort).to eq %w[/aboutme h2_content]
          expect(Hiroiyomi).to have_received(:read).once
        end
      end

      context 'when url is nil' do
        it { expect { testee.scan(nil) }.to raise_error(URI::InvalidURIError) }
      end

      context 'when url is empty' do
        it { expect { testee.scan('') }.to raise_error(URI::BadURIError) }
      end
    end
  end
end
