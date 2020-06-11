class AddNewChangesToArticles < ActiveRecord::Migration[6.0]
  def change
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    add_column :articles, :created_at, :datetime
    add_column :articles, :updated_at, :datetime
  end
end
