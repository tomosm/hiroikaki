# frozen_string_literal: true

# ApplicationResource
class ApplicationResource < JSONAPI::Resource
  abstract

  def initialize(model, context)
    super(model.decorate, context)
  end

  def meta(_options)
    { lastUpdatedAt: _model.updated_at }
  end

  class << self
    def updatable_fields(context)
      super - unsavable_fields
    end

    def creatable_fields(context)
      super - unsavable_fields
    end

    def unsavable_fields
      # nop
      []
    end
  end
end
