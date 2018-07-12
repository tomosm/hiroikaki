# frozen_string_literal: true

class CreateElements < ActiveRecord::Migration[5.2]
  def change
    create_table :elements do |t|
      t.references :document, foreign_key: true, null: false, index: true
      t.string :content, null: false

      t.timestamps
    end
  end
end
