class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.text :grammar
      t.string :evaluation_url

      t.timestamps
    end
  end
end
