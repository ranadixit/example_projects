class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :description
      t.datetime :update_at, default:->{'CURRENT_TIMESTAMP'}
      t.timestamp
    end
  end
end
	