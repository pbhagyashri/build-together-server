class AddAuthorToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :author, :integer
  end
end
