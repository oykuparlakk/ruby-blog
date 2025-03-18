class AddPublishAtToArticles < ActiveRecord::Migration[7.2]
  def change
    add_column :articles, :publish_at, :datetime
  end
end
