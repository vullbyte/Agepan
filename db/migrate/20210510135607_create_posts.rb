class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      # t.string :image_id  'carrierwave'の導入時に削除
      t.text :body
      t.string :image

      t.timestamps
    end
  end
end
