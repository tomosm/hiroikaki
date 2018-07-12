# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    url 'https://hiroikaki.herokuapp.com'

    trait :after_parse do
      after(:create) do |document|
        create :element, document: document
        document.proceed!
        document.succeed!
      end
    end
  end
end
