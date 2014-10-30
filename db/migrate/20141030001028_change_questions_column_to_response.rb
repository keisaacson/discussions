class ChangeQuestionsColumnToResponse < ActiveRecord::Migration
  def change
    rename_column :questions, :answer, :response
  end
end
