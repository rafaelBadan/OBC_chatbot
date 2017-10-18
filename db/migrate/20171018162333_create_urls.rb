class CreateUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :urls do |t|
      t.string :pathurl
      t.integer :company_id
    end
  end
end
