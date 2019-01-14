class ChangeAuthorToBeStringInProjects < ActiveRecord::Migration[5.1]
  def change
    change_column :projects, :author, :string
  end
end
