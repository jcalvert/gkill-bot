class CreateInitial < ActiveRecord::Migration[4.2]
  def up
    create_table :schedule do |t|
      t.date :date
      t.text :name
      t.text :description
    end
    puts 'ran up method'
  end 

  def down
    drop_table :schedule
    puts 'ran down method'
  end
end

