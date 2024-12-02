# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Article.create(title: 'dummy data 1', body: "test verisidir 1", status: "public")
Article.create(title: 'dummy data 2', body: "test verisidir 2", status: "public")
Article.create(title: 'dummy data 3', body: "test verisidir 3", status: "public")
Comment.create(commenter: 'Commenter 1', body: "test verisidir 1", article_id: 1, status: "public")
Comment.create(commenter: 'Commenter 2', body: "test verisidir 2", article_id: 1, status: "public")
Comment.create(commenter: 'Commenter 3', body: "test verisidir 3", article_id: 2, status: "public")
Comment.create(commenter: 'Commenter 4', body: "test verisidir 4", article_id: 3, status: "public")
