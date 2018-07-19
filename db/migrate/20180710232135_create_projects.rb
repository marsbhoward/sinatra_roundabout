class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
     t.integer :project_id
     t.integer :user_id
     t.string :project_name
     t.string :description
     t.string :contributors
     t.string :content
   end
  end
end
