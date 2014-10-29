class AddLeaderEmailToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :leader_email, :string
  end
end
