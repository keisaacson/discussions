class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :title
      t.string :leader_code
      t.string :participant_code

      t.timestamps
    end
  end
end
