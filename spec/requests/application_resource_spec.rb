# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationResource, type: :request do
  include Rack::Test::Methods

  describe '/' do
    describe 'GET' do
      it do
        get documents_path

        # Check status code
        expect(last_response.status).to eq 200

        # Check JSON
        json = JSON.parse(last_response.body)
        expect(json['data']).to eq([])
      end
    end
  end
end
