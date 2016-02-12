class CreateQuestions < ActiveRecord::Migration
  def change
    # no need to specify an 'id' column. ActiveRecord automatically create integer field called id with AUTOINCREMENT
    create_table :questions do |t|
      t.string :title
      t.text :body

      t.timestamps null: false
      # timestamps will add two datetime fields: created at and updated at
    end
  end
end
