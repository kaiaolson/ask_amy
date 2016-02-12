class AddIndiciesToQuestions < ActiveRecord::Migration
  def change
    # this will ad an index (not unique) to the questions table on the title column
    add_index :questions, :title
    add_index :questions, :body

    # to create a unique index
    # add_index :questions, :body, unique: true
    
    # to create a composite index:
    # add_index :questions, [:title, :body]
  end
end
