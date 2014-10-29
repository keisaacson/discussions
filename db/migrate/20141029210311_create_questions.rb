class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :content
      t.references :discussion, index: true
      t.string :question_status
      t.text :answer

      t.timestamps
    end
  end
end
