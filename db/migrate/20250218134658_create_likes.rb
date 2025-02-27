class CreateLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end

    add_index :likes, [ :user_id, :article_id ], unique: true # Bir kullanıcı bir makaleyi bir kez beğenebilir
  end
end
