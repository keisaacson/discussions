class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.text :survey_question
      t.text :correct_answer
      t.references :discussion, index: true

      t.timestamps
    end
  end
end
