class AddBodyToArticles < ActiveRecord::Migration[7.2]
  def change
    unless column_exists?(:articles, :body)
      add_column :articles, :body, :text
    end
  end
end
