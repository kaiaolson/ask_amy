class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body
      # t.references :question will generate integer field called question_id - this is rails convention;
      # index: true will auto create an index on the question_id field
      # foreign_key: true will auto create a foreign key constraint for the question_id field
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
