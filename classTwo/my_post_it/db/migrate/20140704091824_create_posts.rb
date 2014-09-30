class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :url, :title
      t.text :description
      t.references :user, index: true
    end
  end
end
