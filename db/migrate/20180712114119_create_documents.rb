# frozen_string_literal: true

class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :url, null: false
      t.integer :status, null: false, default: Document.statuses[:non]
      t.integer :lock_version, default: 0

      t.timestamps
    end
  end
end
