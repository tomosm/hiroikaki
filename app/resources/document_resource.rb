# frozen_string_literal: true

# DocumentResource
class DocumentResource < ApplicationResource
  attributes :url, :status, :contents

  class << self
    def unsavable_fields
      %i[status contents]
    end
  end
end
