class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :main_url
      t.string :small_url

      t.timestamps
    end
  end
end
