# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DocumentResource, type: :request do
  include Rack::Test::Methods

  before(:all) do
    @default_queue_adapter        = ActiveJob::Base.queue_adapter
    ActiveJob::Base.queue_adapter = :test
  end

  after(:all) do
    ActiveJob::Base.queue_adapter = @default_queue_adapter
  end

  describe '/documents' do
    describe 'GET' do
      context 'without data' do
        it do
          get documents_path

          expect(last_response.status).to eq 200

          json = JSON.parse(last_response.body)
          expect(json['data']).to eq([])
        end
      end

      context 'with data' do
        before { @documents = DocumentDecorator.decorate_collection [create(:document), create(:document, :after_parse)] }

        it do
          get documents_path

          expect(last_response.status).to eq 200

          json = JSON.parse(last_response.body)
          @documents.each_with_index do |document, i|
            expect(json['data'][i]['id']).to eq(document.id.to_s)
            expect(json['data'][i]['attributes']['url']).to eq(document.url)
            expect(json['data'][i]['attributes']['contents']).to eq(document.contents)
          end
        end
      end
    end

    describe 'POST' do
      before { header 'Content-Type', 'application/vnd.api+json' }
      it 'creates a document' do
        post documents_path, { data: { type: 'documents', attributes: { url: 'https://hiroikaki.herokuapp.com' } } }.to_json

        expect(last_response.status).to eq 201

        expect(last_response.location).to match(/#{document_path(Document.last)}$/)
      end

      context 'when header is invalid' do
        before { header 'Content-Type', '' }
        it "must use the 'application/vnd.api+json' Content-Type" do
          post documents_path, params: { data: { type: 'documents', attributes: { url: 'https://hiroikaki.herokuapp.com' } } }.to_json
          expect(last_response.status).to eq 415
        end
      end

      context 'when to update unsavable fields' do
        { status: 0, contents: %w[unsavable] }.each do |key, value|
          it do
            post documents_path, { data: { type: 'documents', attributes: { url: 'https://hiroikaki.herokuapp.com', key => value } } }.to_json
            expect(last_response.status).to eq 400
          end
        end
      end
    end
  end

  describe '/documents/:id' do
    before { @document = create(:document, :after_parse).decorate }
    describe 'GET' do
      it 'returns a specific document' do
        get document_path(@document)

        expect(last_response.status).to eq 200

        json = JSON.parse(last_response.body)
        expect(json['data']['id']).to eq(@document.id.to_s)
        expect(json['data']['attributes']['url']).to eq(@document.url)
        expect(json['data']['attributes']['contents']).to eq(@document.contents)
      end
    end

    describe 'DELETE' do
      it 'deletes a specific document' do
        delete document_path(@document)

        expect(last_response.status).to eq 204
        expect(Document.find_by(id: @document.id)).to be_nil
      end
    end

    describe 'PUT|PATCH' do
      before { header 'Content-Type', 'application/vnd.api+json' }
      it 'updates url' do
        expect(@document.elements.length).not_to eq 0

        put document_path(@document), { data: { id: @document.id, type: 'documents', attributes: { url: 'https://google.com' } } }.to_json

        expect(last_response.status).to eq 200

        json = JSON.parse(last_response.body)
        expect(json['data']['attributes']['url']).to eq('https://google.com')
        expect(@document.reload.status).to eq 'initial'
        expect(@document.elements.length).to eq 0
      end

      context 'when to update unsavable fields' do
        { status: 0, contents: %w[unsavable] }.each do |key, value|
          it do
            put document_path(@document), { data: { id: @document.id, type: 'documents', attributes: { key => value } } }.to_json
            expect(last_response.status).to eq 400
          end
        end
      end

      context 'when header is invalid' do
        before { header 'Content-Type', '' }
        it "must use the 'application/vnd.api+json' Content-Type" do
          put document_path(@document), params: { data: { id: @document.id, type: 'documents', attributes: { url: 'https://google.com' } } }.to_json
          expect(last_response.status).to eq 415
        end
      end
    end
  end
end
