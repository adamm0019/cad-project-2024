class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.integer :status, default: 0
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :due_date
      t.integer :priority, default: 0

      t.timestamps
    end
  end
end
