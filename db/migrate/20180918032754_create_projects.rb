class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :technologies
      t.string :duration
      t.text :description
      t.string :github_link

      t.timestamps
    end
  end
end
