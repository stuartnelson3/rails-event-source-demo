class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.boolean :completed, default: 0
      t.string :name
      t.timestamps
    end
  end
end
