class CreateGameEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :game_events do |t|
      t.string :event_type, null: false
      t.references :game, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :occurred_at, null: false

      t.timestamps
    end
  end
end
