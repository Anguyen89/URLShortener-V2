class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :visitor_id, null: false
      t.integer :shortened_url_id, null: false

      t.timestamps null: false
    end

    add_index :visits, :visitor_id
    add_index :visits, :shortened_url_id
  end
end
