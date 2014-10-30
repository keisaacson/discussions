class AddSurveyStatustoSurveysTable < ActiveRecord::Migration
  def change
    add_column :surveys, :survey_status, :string
  end
end
