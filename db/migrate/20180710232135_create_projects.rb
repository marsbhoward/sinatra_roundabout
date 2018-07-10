class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
     t.integer :project_id
     t.integer :creator_id
     t.string :project_name
     t.string :description
     t.string :contributors
   end
  end
end
