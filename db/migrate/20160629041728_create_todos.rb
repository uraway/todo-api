class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.references  :user, index: true
      t.text        :text, null: false, default: ""
      t.boolean     :completed, null: false, default: false
      t.timestamps
    end
  end
end
